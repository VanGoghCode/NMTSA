/**
 * API Client Configuration
 * Centralized HTTP client for making API requests
 */

const API_BASE_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3000/api';

interface RequestOptions extends RequestInit {
  params?: Record<string, string | number | boolean>;
}

class ApiClient {
  private baseURL: string;

  constructor(baseURL: string) {
    this.baseURL = baseURL;
  }

  private buildURL(endpoint: string, params?: Record<string, string | number | boolean>): string {
    const url = new URL(endpoint, this.baseURL);
    if (params) {
      Object.entries(params).forEach(([key, value]) => {
        url.searchParams.append(key, String(value));
      });
    }
    return url.toString();
  }

  private async handleResponse<T>(response: Response): Promise<T> {
    if (!response.ok) {
      const error = await response.json().catch(() => ({ message: response.statusText }));
      throw new Error(error.message || 'Request failed');
    }
    return response.json();
  }

  async get<T>(endpoint: string, options?: RequestOptions): Promise<T> {
    const url = this.buildURL(endpoint, options?.params);
    const response = await fetch(url, {
      ...options,
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
        ...options?.headers,
      },
    });
    return this.handleResponse<T>(response);
  }

  async post<T>(endpoint: string, data?: unknown, options?: RequestOptions): Promise<T> {
    const url = this.buildURL(endpoint, options?.params);
    const response = await fetch(url, {
      ...options,
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        ...options?.headers,
      },
      body: JSON.stringify(data),
    });
    return this.handleResponse<T>(response);
  }

  async put<T>(endpoint: string, data?: unknown, options?: RequestOptions): Promise<T> {
    const url = this.buildURL(endpoint, options?.params);
    const response = await fetch(url, {
      ...options,
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
        ...options?.headers,
      },
      body: JSON.stringify(data),
    });
    return this.handleResponse<T>(response);
  }

  async delete<T>(endpoint: string, options?: RequestOptions): Promise<T> {
    const url = this.buildURL(endpoint, options?.params);
    const response = await fetch(url, {
      ...options,
      method: 'DELETE',
      headers: {
        'Content-Type': 'application/json',
        ...options?.headers,
      },
    });
    return this.handleResponse<T>(response);
  }
}

export const apiClient = new ApiClient(API_BASE_URL);
