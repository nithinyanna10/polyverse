"""
API routes for the hub service
"""

from fastapi import APIRouter, HTTPException
from typing import Dict, Any
from ..event_bus import EventBus

# Get event bus instance (will be set by main.py)
event_bus = None

def set_event_bus(bus):
    global event_bus
    event_bus = bus

router = APIRouter(prefix="/api/v1", tags=["api"])

@router.get("/events")
async def get_events(event_type: str = None, limit: int = 100):
    """Get recent events from the event bus"""
    if event_bus is None:
        raise HTTPException(status_code=503, detail="Event bus not initialized")
    return {
        "events": event_bus.get_history(event_type, limit),
        "count": len(event_bus.get_history(event_type, limit))
    }

@router.post("/events")
async def publish_event(event: Dict[str, Any]):
    """Publish a new event to the event bus"""
    if event_bus is None:
        raise HTTPException(status_code=503, detail="Event bus not initialized")
    if "type" not in event:
        raise HTTPException(status_code=400, detail="Event must have a 'type' field")
    
    await event_bus.publish(event["type"], event.get("payload", {}))
    return {"status": "published", "event_type": event["type"]}

@router.get("/status")
async def get_status():
    """Get hub status"""
    if event_bus is None:
        raise HTTPException(status_code=503, detail="Event bus not initialized")
    return {
        "hub": "operational",
        "event_bus": event_bus.status()
    }

