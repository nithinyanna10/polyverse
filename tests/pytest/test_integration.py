"""
Cross-language integration tests
"""

import pytest
import requests
import time

HUB_URL = "http://localhost:8000"
RUST_SIGNAL_URL = "http://localhost:8080"
GO_ORCHESTRATOR_URL = "http://localhost:8081"
JAVA_RECOMMENDER_URL = "http://localhost:8082"

@pytest.fixture(scope="module")
def wait_for_services():
    """Wait for all services to be ready"""
    services = [
        (HUB_URL, "/health"),
        (RUST_SIGNAL_URL, "/health"),
        (GO_ORCHESTRATOR_URL, "/health"),
        (JAVA_RECOMMENDER_URL, "/api/v1/health"),
    ]
    
    for base_url, endpoint in services:
        max_retries = 30
        for _ in range(max_retries):
            try:
                response = requests.get(f"{base_url}{endpoint}", timeout=2)
                if response.status_code == 200:
                    break
            except:
                time.sleep(1)
        else:
            pytest.fail(f"Service {base_url} not ready")

def test_hub_health():
    """Test hub health endpoint"""
    response = requests.get(f"{HUB_URL}/health")
    assert response.status_code == 200
    assert response.json()["status"] == "healthy"

def test_event_flow():
    """Test event flow through the system"""
    # Publish event to hub
    event = {
        "type": "test_event",
        "payload": {"test": "data"}
    }
    response = requests.post(f"{HUB_URL}/api/v1/events", json=event)
    assert response.status_code == 200
    
    # Verify event in history
    response = requests.get(f"{HUB_URL}/api/v1/events?event_type=test_event")
    assert response.status_code == 200
    events = response.json()["events"]
    assert len(events) > 0

def test_rust_signal_processing():
    """Test Rust Signal event processing"""
    event = {
        "event_type": "test",
        "payload": {"data": "test"},
        "timestamp": "2024-01-01T00:00:00Z"
    }
    response = requests.post(f"{RUST_SIGNAL_URL}/events", json=event)
    assert response.status_code == 200

def test_go_orchestrator_tasks():
    """Test Go Orchestrator task management"""
    task = {
        "type": "test_task",
        "payload": "test"
    }
    response = requests.post(f"{GO_ORCHESTRATOR_URL}/tasks", json=task)
    assert response.status_code == 200
    
    # Get tasks
    response = requests.get(f"{GO_ORCHESTRATOR_URL}/tasks")
    assert response.status_code == 200
    assert len(response.json()["tasks"]) > 0

def test_java_recommender():
    """Test Java Recommender"""
    request = {
        "user_id": "test_user",
        "item_type": "product"
    }
    response = requests.post(f"{JAVA_RECOMMENDER_URL}/api/v1/recommend", json=request)
    assert response.status_code == 200
    assert "recommendations" in response.json()

