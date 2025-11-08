/**
 * 🎨 Front-end portal - Next.js + D3.js + Three.js
 * Main dashboard page
 */

import { useEffect, useRef, useState } from 'react';
import * as d3 from 'd3';
import * as THREE from 'three';

interface AgentNode {
  id: string;
  type: string;
  status: string;
  x?: number;
  y?: number;
}

export default function Dashboard() {
  const [agents, setAgents] = useState<AgentNode[]>([]);
  const d3Container = useRef<HTMLDivElement>(null);
  const threeContainer = useRef<HTMLDivElement>(null);

  useEffect(() => {
    // Fetch agents from hub
    fetch('http://localhost:8000/api/v1/status')
      .then(res => res.json())
      .then(data => {
        if (data.agents) {
          setAgents(data.agents);
        }
      });

    // Initialize D3.js force graph
    if (d3Container.current) {
      const width = 800;
      const height = 600;

      const svg = d3.select(d3Container.current)
        .append('svg')
        .attr('width', width)
        .attr('height', height);

      const simulation = d3.forceSimulation(agents)
        .force('link', d3.forceLink().id((d: any) => d.id))
        .force('charge', d3.forceManyBody().strength(-300))
        .force('center', d3.forceCenter(width / 2, height / 2));

      const node = svg.append('g')
        .selectAll('circle')
        .data(agents)
        .enter()
        .append('circle')
        .attr('r', 10)
        .attr('fill', (d: any) => d.status === 'active' ? '#4caf50' : '#ff9800');

      const label = svg.append('g')
        .selectAll('text')
        .data(agents)
        .enter()
        .append('text')
        .text((d: any) => d.type)
        .attr('font-size', 12)
        .attr('dx', 15)
        .attr('dy', 4);

      simulation.on('tick', () => {
        node
          .attr('cx', (d: any) => d.x)
          .attr('cy', (d: any) => d.y);
        label
          .attr('x', (d: any) => d.x)
          .attr('y', (d: any) => d.y);
      });

      return () => {
        svg.remove();
      };
    }
  }, [agents]);

  useEffect(() => {
    // Initialize Three.js scene
    if (threeContainer.current) {
      const scene = new THREE.Scene();
      const camera = new THREE.PerspectiveCamera(
        75,
        threeContainer.current.clientWidth / threeContainer.current.clientHeight,
        0.1,
        1000
      );
      const renderer = new THREE.WebGLRenderer({ antialias: true });
      renderer.setSize(threeContainer.current.clientWidth, 400);
      threeContainer.current.appendChild(renderer.domElement);

      const geometry = new THREE.BoxGeometry(1, 1, 1);
      const material = new THREE.MeshBasicMaterial({ color: 0x00ff00 });
      const cube = new THREE.Mesh(geometry, material);
      scene.add(cube);

      camera.position.z = 5;

      const animate = () => {
        requestAnimationFrame(animate);
        cube.rotation.x += 0.01;
        cube.rotation.y += 0.01;
        renderer.render(scene, camera);
      };
      animate();

      return () => {
        renderer.dispose();
      };
    }
  }, []);

  return (
    <div className="dashboard">
      <h1>🎨 Polyverse Dashboard</h1>
      
      <section className="d3-visualization">
        <h2>Agent Network (D3.js)</h2>
        <div ref={d3Container}></div>
      </section>

      <section className="three-visualization">
        <h2>3D Visualization (Three.js)</h2>
        <div ref={threeContainer}></div>
      </section>

      <section className="agents-list">
        <h2>Active Agents</h2>
        <ul>
          {agents.map(agent => (
            <li key={agent.id}>
              {agent.type} - {agent.status}
            </li>
          ))}
        </ul>
      </section>

      <style jsx>{`
        .dashboard {
          padding: 20px;
          font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
        }
        .d3-visualization,
        .three-visualization {
          margin: 20px 0;
          border: 1px solid #e0e0e0;
          border-radius: 8px;
          padding: 20px;
        }
        .agents-list ul {
          list-style: none;
          padding: 0;
        }
        .agents-list li {
          padding: 10px;
          margin: 5px 0;
          background: #f5f5f5;
          border-radius: 4px;
        }
      `}</style>
    </div>
  );
}

