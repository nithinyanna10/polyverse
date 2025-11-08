/**
 * API client for communicating with the Polyverse Hub
 */

const HUB_URL = process.env.REACT_APP_HUB_URL || 'http://localhost:8000';

export interface Event {
  type: string;
  payload: any;
  timestamp: string;
}

export interface HubStatus {
  hub: string;
  event_bus: {
    subscribers: Record<string, number>;
    total_events: number;
    active_channels: number;
  };
}

export class HubClient {
  private baseUrl: string;

  constructor(baseUrl: string = HUB_URL) {
    this.baseUrl = baseUrl;
  }

  async getStatus(): Promise<HubStatus> {
    const response = await fetch(`${this.baseUrl}/api/v1/status`);
    if (!response.ok) {
      throw new Error(`Failed to fetch status: ${response.statusText}`);
    }
    return response.json();
  }

  async getEvents(eventType?: string, limit: number = 100): Promise<Event[]> {
    const params = new URLSearchParams();
    if (eventType) params.append('event_type', eventType);
    params.append('limit', limit.toString());

    const response = await fetch(`${this.baseUrl}/api/v1/events?${params}`);
    if (!response.ok) {
      throw new Error(`Failed to fetch events: ${response.statusText}`);
    }
    const data = await response.json();
    return data.events;
  }

  async publishEvent(eventType: string, payload: any): Promise<void> {
    const response = await fetch(`${this.baseUrl}/api/v1/events`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        type: eventType,
        payload,
      }),
    });

    if (!response.ok) {
      throw new Error(`Failed to publish event: ${response.statusText}`);
    }
  }
}

