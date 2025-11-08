"""
🌐 Central command bus - FastAPI + gRPC + WebSocket
Main entry point for the hub service that coordinates all agents.
"""

from fastapi import FastAPI, WebSocket, WebSocketDisconnect
from fastapi.middleware.cors import CORSMiddleware
import uvicorn
import asyncio
from typing import List

from .event_bus import EventBus
from .routes.api import router, set_event_bus

app = FastAPI(
    title="Polyverse Hub",
    description="Central command bus for multi-agent coordination",
    version="0.1.0"
)

# CORS configuration
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Initialize event bus (global instance)
event_bus = EventBus()

# Set event bus in routes module
set_event_bus(event_bus)

# Include routes
app.include_router(router)

# WebSocket connections manager
class ConnectionManager:
    def __init__(self):
        self.active_connections: List[WebSocket] = []

    async def connect(self, websocket: WebSocket):
        await websocket.accept()
        self.active_connections.append(websocket)

    def disconnect(self, websocket: WebSocket):
        self.active_connections.remove(websocket)

    async def broadcast(self, message: dict):
        for connection in self.active_connections:
            try:
                await connection.send_json(message)
            except:
                pass

manager = ConnectionManager()

@app.get("/")
async def root():
    """Health check endpoint"""
    return {
        "service": "Polyverse Hub",
        "status": "operational",
        "version": "0.1.0"
    }

@app.get("/health")
async def health():
    """Detailed health check"""
    return {
        "status": "healthy",
        "event_bus": event_bus.status(),
        "active_connections": len(manager.active_connections)
    }

@app.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    """WebSocket endpoint for real-time communication"""
    await manager.connect(websocket)
    try:
        while True:
            data = await websocket.receive_json()
            # Broadcast to all connected clients
            await manager.broadcast({
                "type": "message",
                "data": data,
                "timestamp": asyncio.get_event_loop().time()
            })
    except WebSocketDisconnect:
        manager.disconnect(websocket)

if __name__ == "__main__":
    uvicorn.run(
        "hub.app.main:app",
        host="0.0.0.0",
        port=8000,
        reload=True
    )

