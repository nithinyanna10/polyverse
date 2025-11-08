# 🚀 Polyverse-X

A multi-agent AI system built with multiple programming languages, coordinated through a central hub. This project demonstrates polyglot architecture with services in Python, Rust, Go, Java, C++, Swift, and JavaScript.

## 📋 Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Components](#components)
- [Quick Start](#quick-start)
- [Development](#development)
- [Documentation](#documentation)
- [Contributing](#contributing)

## 🌐 Overview

Polyverse-X is a distributed system that coordinates multiple AI agents and services across different programming languages. The system uses a central hub (FastAPI) for coordination, with specialized services for different tasks:

- **🧠 Cognitive Processing**: Python agents with LangChain, Ollama, Qwen3
- **⚡ Real-time Processing**: Rust services for high-performance event handling
- **🧭 Orchestration**: Go services for task scheduling and metrics
- **⚙️ Compute Engine**: C++ backend for high-performance computations
- **💡 ML Recommendations**: Java Spring Boot service
- **📸 Computer Vision**: Swift Vision framework integration
- **🎨 Visualization**: Next.js dashboard with D3.js and Three.js

## 🏗️ Architecture

```
┌──────────────────────────────┐
│      Observatory (React)     │
│  Visualizes AI collaboration │
└──────────┬───────────────────┘
           │ WebSocket + REST
           ▼
┌──────────────────────────────┐
│          HUB (FastAPI)       │
│   Event bus / Message queue  │
└──────────┬───────────────────┘
           │ gRPC / HTTP
┌──────────┼────────────────────┐
│  Python Agent   Go Scheduler  │
│  Rust Signal     Java ML      │
│  C++ Engine      Swift Vision │
└────────────────────────────────┘
```

See [docs/architecture.md](docs/architecture.md) for detailed architecture documentation.

## 📦 Components

### 🌐 Hub (`hub/`)
Central command bus built with FastAPI, supporting WebSocket and REST APIs.
- FastAPI application
- Event bus for pub/sub messaging
- WebSocket support for real-time communication
- Agent coordination

### 📊 Observatory (`observatory/`)
React dashboard for live visualization of system activity.
- Real-time metrics visualization
- Agent status monitoring
- WebSocket integration

### 🧠 Python Agent (`python_agent/`)
Cognitive core using LangChain, Ollama, and Qwen3.
- AI reasoning and decision making
- Memory management
- Tool system for extensibility
- LLM integration

### ⚡ Rust Signal (`rust_signal/`)
High-performance event processor using Actix and Tokio.
- Real-time event processing
- Async/await support
- High throughput

### 🧭 Go Orchestrator (`go_orchestrator/`)
Task scheduler and metrics service.
- Task management
- Metrics collection
- Service coordination

### ⚙️ C++ Engine (`cpp_engine/`)
High-performance compute backend.
- Matrix operations (Eigen)
- REST bridge for integration
- Compute-intensive tasks

### 💡 Java Recommender (`java_recommender/`)
ML recommendation engine using Spring Boot.
- RESTful API
- Recommendation algorithms
- Spring Boot framework

### 📸 Swift Vision (`swift_vision/`)
Computer vision module for macOS/iOS.
- Vision framework integration
- Image processing
- Object detection

### 🎨 JS Dashboard (`js_dashboard/`)
Front-end portal with Next.js, D3.js, and Three.js.
- Interactive visualizations
- 3D graphics
- Real-time updates

### 🧮 Data Pipeline (`data_pipeline/`)
ETL, analytics, and LLM summarization.
- Airflow orchestration
- Spark jobs
- Jupyter notebooks

### 🧰 Infrastructure (`infra/`)
DevOps automation and deployment.
- Docker Compose
- Kubernetes manifests
- Terraform configurations
- CI/CD pipelines
- Monitoring (Prometheus + Grafana)

## 🚀 Quick Start

### Prerequisites

- Docker and Docker Compose
- Python 3.11+
- Node.js 18+
- Go 1.21+
- Rust (latest stable)
- Java 17+
- Maven

### Using Docker Compose

```bash
# Clone the repository
git clone https://github.com/nithinyanna10/polyverse.git
cd polyverse

# Start all services
cd infra
docker-compose up -d

# Verify services
curl http://localhost:8000/health
```

### Manual Setup

See [docs/setup_guide.md](docs/setup_guide.md) for detailed setup instructions for each service.

## 💻 Development

### Running Tests

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

### Project Structure

```
polyverse-x/
├── hub/                      # 🌐 Central command bus
├── observatory/              # 📊 Streamlit/React dashboard
├── python_agent/             # 🧠 Cognitive core
├── rust_signal/              # ⚡ Real-time event processor
├── go_orchestrator/          # 🧭 Task scheduler & metrics
├── cpp_engine/               # ⚙️ High-perf compute backend
├── java_recommender/         # 💡 ML recommendation engine
├── swift_vision/             # 📸 macOS/iOS CV module
├── js_dashboard/             # 🎨 Front-end portal
├── data_pipeline/            # 🧮 ETL + analytics + LLM
├── infra/                    # 🧰 DevOps automation
├── scripts/                  # 🐚 Utility scripts
├── docs/                     # 📚 Developer handbook
└── tests/                    # 🧪 Cross-language integration tests
```

## 📚 Documentation

- [Architecture](docs/architecture.md) - System architecture overview
- [API Reference](docs/api_reference.md) - API documentation
- [Setup Guide](docs/setup_guide.md) - Detailed setup instructions

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is open source and available under the MIT License.

## 🔗 Links

- GitHub: https://github.com/nithinyanna10/polyverse
- Documentation: See `docs/` directory

---

Built with ❤️ using multiple programming languages

