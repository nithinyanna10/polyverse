# 🚀 Setup Guide

## Prerequisites

- Docker and Docker Compose
- Python 3.11+
- Node.js 18+
- Go 1.21+
- Rust (latest stable)
- Java 17+
- Maven

## Quick Start

### 1. Clone the repository
```bash
git clone https://github.com/nithinyanna10/polyverse.git
cd polyverse
```

### 2. Start all services with Docker Compose
```bash
cd infra
docker-compose up -d
```

This will start:
- Hub (port 8000)
- Observatory (port 3000)
- All agent services
- PostgreSQL (port 5432)
- Prometheus (port 9090)
- Grafana (port 3001)

### 3. Verify services
```bash
# Check hub
curl http://localhost:8000/health

# Check Rust Signal
curl http://localhost:8080/health

# Check Go Orchestrator
curl http://localhost:8081/health
```

## Development Setup

### Hub (Python)
```bash
cd hub
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install -r requirements.txt
uvicorn hub.app.main:app --reload
```

### Observatory (React)
```bash
cd observatory
npm install
npm start
```

### Python Agent
```bash
cd python_agent
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python agent.py
```

### Rust Signal
```bash
cd rust_signal
cargo build
cargo run
```

### Go Orchestrator
```bash
cd go_orchestrator
go mod download
go run main.go
```

### Java Recommender
```bash
cd java_recommender
mvn clean install
mvn spring-boot:run
```

### C++ Engine
```bash
cd cpp_engine
mkdir build && cd build
cmake ..
make
./cpp_engine
```

## Running Tests

```bash
# Python tests
cd hub && pytest
cd ../python_agent && pytest

# Node.js tests
cd observatory && npm test
cd ../js_dashboard && npm test

# Go tests
cd go_orchestrator && go test ./...

# Rust tests
cd rust_signal && cargo test

# Java tests
cd java_recommender && mvn test
```

## Configuration

Environment variables can be set in `.env` files or passed to Docker containers.

Key variables:
- `HUB_URL`: URL of the hub service
- `DATABASE_URL`: PostgreSQL connection string
- `ENV`: Environment (development/production)

## Troubleshooting

### Port conflicts
If ports are already in use, modify `docker-compose.yml` or stop conflicting services.

### Service not starting
Check logs:
```bash
docker-compose logs <service_name>
```

### Database connection issues
Ensure PostgreSQL is running and credentials match in configuration.

