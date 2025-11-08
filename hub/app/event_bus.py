"""
Event bus for coordinating messages between agents and services.
"""

from typing import Dict, List, Callable, Any
import asyncio
from datetime import datetime
import json

class EventBus:
    """Central event bus for pub/sub messaging"""
    
    def __init__(self):
        self.subscribers: Dict[str, List[Callable]] = {}
        self.event_history: List[Dict[str, Any]] = []
        self.max_history = 1000
    
    def subscribe(self, event_type: str, callback: Callable):
        """Subscribe to an event type"""
        if event_type not in self.subscribers:
            self.subscribers[event_type] = []
        self.subscribers[event_type].append(callback)
    
    def unsubscribe(self, event_type: str, callback: Callable):
        """Unsubscribe from an event type"""
        if event_type in self.subscribers:
            if callback in self.subscribers[event_type]:
                self.subscribers[event_type].remove(callback)
    
    async def publish(self, event_type: str, payload: Dict[str, Any]):
        """Publish an event to all subscribers"""
        event = {
            "type": event_type,
            "payload": payload,
            "timestamp": datetime.utcnow().isoformat()
        }
        
        # Store in history
        self.event_history.append(event)
        if len(self.event_history) > self.max_history:
            self.event_history.pop(0)
        
        # Notify subscribers
        if event_type in self.subscribers:
            for callback in self.subscribers[event_type]:
                try:
                    if asyncio.iscoroutinefunction(callback):
                        await callback(event)
                    else:
                        callback(event)
                except Exception as e:
                    print(f"Error in subscriber callback: {e}")
    
    def get_history(self, event_type: str = None, limit: int = 100) -> List[Dict]:
        """Get event history, optionally filtered by type"""
        history = self.event_history
        if event_type:
            history = [e for e in history if e["type"] == event_type]
        return history[-limit:]
    
    def status(self) -> Dict[str, Any]:
        """Get event bus status"""
        return {
            "subscribers": {k: len(v) for k, v in self.subscribers.items()},
            "total_events": len(self.event_history),
            "active_channels": len(self.subscribers)
        }

