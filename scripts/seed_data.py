#!/usr/bin/env python3
"""
Seed script for populating initial data
"""

import asyncio
import json
from datetime import datetime

async def seed_data():
    """Seed initial data into the system"""
    
    # Example: Seed agent configurations
    agents = [
        {
            "agent_id": "python_agent_001",
            "type": "cognitive",
            "status": "ready",
            "created_at": datetime.utcnow().isoformat()
        },
        {
            "agent_id": "rust_signal_001",
            "type": "processor",
            "status": "ready",
            "created_at": datetime.utcnow().isoformat()
        }
    ]
    
    print("Seeding agents...")
    for agent in agents:
        print(f"  - {agent['agent_id']}: {agent['type']}")
    
    # TODO: Actually insert into database or send to hub
    print("\n✅ Data seeding complete!")

if __name__ == "__main__":
    asyncio.run(seed_data())

