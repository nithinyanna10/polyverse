# 📚 API Reference

## Hub API

### Base URL
```
http://localhost:8000
```

### Endpoints

#### GET `/`
Health check endpoint.

**Response:**
```json
{
  "service": "Polyverse Hub",
  "status": "operational",
  "version": "0.1.0"
}
```

#### GET `/health`
Detailed health check.

**Response:**
```json
{
  "status": "healthy",
  "event_bus": {
    "subscribers": {},
    "total_events": 0,
    "active_channels": 0
  },
  "active_connections": 0
}
```

#### GET `/api/v1/events`
Get recent events from the event bus.

**Query Parameters:**
- `event_type` (optional): Filter by event type
- `limit` (optional, default: 100): Maximum number of events to return

#### POST `/api/v1/events`
Publish a new event.

**Request Body:**
```json
{
  "type": "agent_task",
  "payload": {
    "task_id": "task_123",
    "data": {}
  }
}
```

#### WebSocket `/ws`
Real-time WebSocket connection for bidirectional communication.

## Rust Signal API

### Base URL
```
http://localhost:8080
```

#### GET `/health`
Health check.

#### POST `/events`
Queue an event for processing.

#### GET `/stats`
Get processing statistics.

## Go Orchestrator API

### Base URL
```
http://localhost:8081
```

#### GET `/health`
Health check.

#### GET `/tasks`
Get all tasks.

#### POST `/tasks`
Create a new task.

#### GET `/metrics`
Get collected metrics.

## Java Recommender API

### Base URL
```
http://localhost:8082
```

#### GET `/api/v1/health`
Health check.

#### POST `/api/v1/recommend`
Get recommendations.

**Request Body:**
```json
{
  "user_id": "user123",
  "item_type": "product"
}
```

#### GET `/api/v1/recommendations/{userId}`
Get recommendations for a user.

