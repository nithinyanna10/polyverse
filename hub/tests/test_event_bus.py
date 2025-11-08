"""
Tests for the event bus
"""

import pytest
import asyncio
from hub.app.event_bus import EventBus

@pytest.fixture
def event_bus():
    return EventBus()

@pytest.mark.asyncio
async def test_publish_subscribe(event_bus):
    """Test basic pub/sub functionality"""
    received_events = []
    
    async def callback(event):
        received_events.append(event)
    
    event_bus.subscribe("test_event", callback)
    await event_bus.publish("test_event", {"data": "test"})
    
    await asyncio.sleep(0.1)  # Allow async processing
    assert len(received_events) == 1
    assert received_events[0]["type"] == "test_event"

@pytest.mark.asyncio
async def test_event_history(event_bus):
    """Test event history storage"""
    await event_bus.publish("test_event", {"data": "test1"})
    await event_bus.publish("test_event", {"data": "test2"})
    
    history = event_bus.get_history("test_event")
    assert len(history) == 2

