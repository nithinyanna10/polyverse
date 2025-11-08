#!/bin/bash
# 🐚 Deployment script

set -e

echo "🚀 Deploying Polyverse..."

# Build all services
echo "📦 Building services..."
docker-compose -f infra/docker-compose.yml build

# Run tests
echo "🧪 Running tests..."
docker-compose -f infra/docker-compose.yml run --rm hub pytest
docker-compose -f infra/docker-compose.yml run --rm python_agent python -m pytest

# Deploy
echo "🚀 Starting services..."
docker-compose -f infra/docker-compose.yml up -d

echo "✅ Deployment complete!"
echo "🌐 Hub: http://localhost:8000"
echo "📊 Observatory: http://localhost:3000"
echo "📈 Grafana: http://localhost:3001"

