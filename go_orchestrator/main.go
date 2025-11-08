/**
 * 🧭 Task scheduler & metrics service
 * Go-based orchestrator for task scheduling and metrics collection
 */

package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"sync"
	"time"
)

type Task struct {
	ID        string    `json:"id"`
	Type      string    `json:"type"`
	Payload   string    `json:"payload"`
	Status    string    `json:"status"`
	CreatedAt time.Time `json:"created_at"`
}

type Metric struct {
	Service   string    `json:"service"`
	Value     float64   `json:"value"`
	Timestamp time.Time `json:"timestamp"`
}

type Orchestrator struct {
	tasks   []Task
	metrics []Metric
	mu      sync.RWMutex
}

func NewOrchestrator() *Orchestrator {
	return &Orchestrator{
		tasks:   make([]Task, 0),
		metrics: make([]Metric, 0),
	}
}

func (o *Orchestrator) AddTask(task Task) {
	o.mu.Lock()
	defer o.mu.Unlock()
	task.CreatedAt = time.Now()
	o.tasks = append(o.tasks, task)
}

func (o *Orchestrator) GetTasks() []Task {
	o.mu.RLock()
	defer o.mu.RUnlock()
	return o.tasks
}

func (o *Orchestrator) AddMetric(metric Metric) {
	o.mu.Lock()
	defer o.mu.Unlock()
	metric.Timestamp = time.Now()
	o.metrics = append(o.metrics, metric)
}

func (o *Orchestrator) GetMetrics() []Metric {
	o.mu.RLock()
	defer o.mu.RUnlock()
	return o.metrics
}

func healthHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(map[string]interface{}{
		"service": "Go Orchestrator",
		"status":  "operational",
		"version": "0.1.0",
	})
}

func (o *Orchestrator) tasksHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	tasks := o.GetTasks()
	json.NewEncoder(w).Encode(map[string]interface{}{
		"tasks": tasks,
		"count": len(tasks),
	})
}

func (o *Orchestrator) metricsHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	metrics := o.GetMetrics()
	json.NewEncoder(w).Encode(map[string]interface{}{
		"metrics": metrics,
		"count":   len(metrics),
	})
}

func (o *Orchestrator) createTaskHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
		return
	}

	var task Task
	if err := json.NewDecoder(r.Body).Decode(&task); err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	task.ID = fmt.Sprintf("task_%d", time.Now().Unix())
	task.Status = "pending"
	o.AddTask(task)

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(task)
}

func main() {
	orchestrator := NewOrchestrator()

	http.HandleFunc("/health", healthHandler)
	http.HandleFunc("/tasks", func(w http.ResponseWriter, r *http.Request) {
		if r.Method == http.MethodGet {
			orchestrator.tasksHandler(w, r)
		} else if r.Method == http.MethodPost {
			orchestrator.createTaskHandler(w, r)
		}
	})
	http.HandleFunc("/metrics", orchestrator.metricsHandler)

	fmt.Println("🧭 Go Orchestrator starting on :8081")
	log.Fatal(http.ListenAndServe(":8081", nil))
}

