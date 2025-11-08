package main

import (
	"net/http"
	"testing"
	"time"
)

func TestHubHealth(t *testing.T) {
	resp, err := http.Get("http://localhost:8000/health")
	if err != nil {
		t.Fatalf("Failed to connect to hub: %v", err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		t.Errorf("Expected status 200, got %d", resp.StatusCode)
	}
}

func TestGoOrchestratorHealth(t *testing.T) {
	resp, err := http.Get("http://localhost:8081/health")
	if err != nil {
		t.Fatalf("Failed to connect to orchestrator: %v", err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		t.Errorf("Expected status 200, got %d", resp.StatusCode)
	}
}

