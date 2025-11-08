import React from 'react';

interface AgentCardProps {
  id: string;
  type: string;
  status: string;
}

export const AgentCard: React.FC<AgentCardProps> = ({ id, type, status }) => {
  return (
    <div className="agent-card">
      <h3>{type}</h3>
      <p>ID: {id}</p>
      <p>Status: <span className={`status ${status}`}>{status}</span></p>
    </div>
  );
};

