import React from 'react';
import * as d3 from 'd3';

interface Metric {
  timestamp: string;
  value: number;
}

interface MetricsChartProps {
  data: Metric[];
}

export const MetricsChart: React.FC<MetricsChartProps> = ({ data }) => {
  const svgRef = React.useRef<SVGSVGElement>(null);

  React.useEffect(() => {
    if (!svgRef.current || data.length === 0) return;

    const margin = { top: 20, right: 20, bottom: 40, left: 50 };
    const width = 800 - margin.left - margin.right;
    const height = 400 - margin.top - margin.bottom;

    const svg = d3.select(svgRef.current)
      .attr('width', width + margin.left + margin.right)
      .attr('height', height + margin.top + margin.bottom);

    const g = svg.append('g')
      .attr('transform', `translate(${margin.left},${margin.top})`);

    const x = d3.scaleTime()
      .domain(d3.extent(data, d => new Date(d.timestamp)) as [Date, Date])
      .range([0, width]);

    const y = d3.scaleLinear()
      .domain([0, d3.max(data, d => d.value) || 0])
      .range([height, 0]);

    const line = d3.line<Metric>()
      .x(d => x(new Date(d.timestamp)))
      .y(d => y(d.value));

    g.append('path')
      .datum(data)
      .attr('fill', 'none')
      .attr('stroke', 'steelblue')
      .attr('stroke-width', 2)
      .attr('d', line);

    g.append('g')
      .attr('transform', `translate(0,${height})`)
      .call(d3.axisBottom(x));

    g.append('g')
      .call(d3.axisLeft(y));
  }, [data]);

  return <svg ref={svgRef}></svg>;
};

