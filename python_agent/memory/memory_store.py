"""
Memory store for agent context and history
"""

from typing import List, Dict, Any, Optional
from datetime import datetime
from collections import deque

class MemoryStore:
    """In-memory store for agent memories"""
    
    def __init__(self, max_size: int = 1000):
        self.memories: deque = deque(maxlen=max_size)
        self.max_size = max_size
    
    def add(self, memory: Dict[str, Any]):
        """Add a memory"""
        memory["timestamp"] = datetime.utcnow().isoformat()
        self.memories.append(memory)
    
    def get(self, limit: int = 100) -> List[Dict[str, Any]]:
        """Get recent memories"""
        return list(self.memories)[-limit:]
    
    def search(self, query: str) -> List[Dict[str, Any]]:
        """Search memories by query"""
        # Simple text search - can be enhanced with embeddings
        results = []
        query_lower = query.lower()
        for memory in self.memories:
            if query_lower in str(memory).lower():
                results.append(memory)
        return results
    
    def clear(self):
        """Clear all memories"""
        self.memories.clear()

