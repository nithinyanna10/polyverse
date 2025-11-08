"""
Tests for the main FastAPI application
"""

import pytest
from fastapi.testclient import TestClient
from hub.app.main import app

client = TestClient(app)

def test_root():
    """Test root endpoint"""
    response = client.get("/")
    assert response.status_code == 200
    assert response.json()["service"] == "Polyverse Hub"

def test_health():
    """Test health endpoint"""
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json()["status"] == "healthy"

