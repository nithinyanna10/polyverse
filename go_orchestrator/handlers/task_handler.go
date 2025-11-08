package handlers

import (
	"encoding/json"
	"net/http"
)

type TaskHandler struct {
	// Add dependencies here
}

func NewTaskHandler() *TaskHandler {
	return &TaskHandler{}
}

func (h *TaskHandler) HandleTask(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(map[string]string{
		"message": "Task handler",
	})
}

