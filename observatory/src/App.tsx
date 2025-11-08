/**
 * 📊 Observatory - Streamlit/React dashboard for live visualization
 * Main React application component
 */

import React, { useEffect, useState } from 'react';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend } from 'recharts';
import './App.css';

interface Metric {
  timestamp: string;
  value: number;
  service: string;
}

interface AgentStatus {
  id: string;
  type: string;
  status: string;
  lastActivity: string;
}

const App: React.FC = () => {
  const [metrics, setMetrics] = useState<Metric[]>([]);
  const [agents, setAgents] = useState<AgentStatus[]>([]);
  const [wsConnected, setWsConnected] = useState(false);

  useEffect(() => {
    // Connect to WebSocket
    const ws = new WebSocket('ws://localhost:8000/ws');
    
    ws.onopen = () => {
      setWsConnected(true);
      console.log('Connected to Polyverse Hub');
    };

    ws.onmessage = (event) => {
      const data = JSON.parse(event.data);
      if (data.type === 'metric') {
        setMetrics(prev => [...prev.slice(-100), data.data]);
      } else if (data.type === 'agent_status') {
        setAgents(data.data);
      }
    };

    ws.onerror = (error) => {
      console.error('WebSocket error:', error);
      setWsConnected(false);
    };

    ws.onclose = () => {
      setWsConnected(false);
    };

    // Fetch initial agent status
    fetch('http://localhost:8000/api/v1/status')
      .then(res => res.json())
      .then(data => {
        if (data.agents) {
          setAgents(data.agents);
        }
      });

    return () => {
      ws.close();
    };
  }, []);

  return (
    <div className="app">
      <header className="app-header">
        <h1>🔭 Polyverse Observatory</h1>
        <div className={`status-indicator ${wsConnected ? 'connected' : 'disconnected'}`}>
          {wsConnected ? '🟢 Connected' : '🔴 Disconnected'}
        </div>
      </header>

      <div className="dashboard">
        <section className="metrics-section">
          <h2>Real-time Metrics</h2>
          <LineChart width={800} height={400} data={metrics}>
            <CartesianGrid strokeDasharray="3 3" />
            <XAxis dataKey="timestamp" />
            <YAxis />
            <Tooltip />
            <Legend />
            <Line type="monotone" dataKey="value" stroke="#8884d8" />
          </LineChart>
        </section>

        <section className="agents-section">
          <h2>Agent Status</h2>
          <div className="agents-grid">
            {agents.map(agent => (
              <div key={agent.id} className="agent-card">
                <h3>{agent.type}</h3>
                <p>ID: {agent.id}</p>
                <p>Status: <span className={`status ${agent.status}`}>{agent.status}</span></p>
                <p>Last Activity: {new Date(agent.lastActivity).toLocaleString()}</p>
              </div>
            ))}
          </div>
        </section>
      </div>
    </div>
  );
};

export default App;

