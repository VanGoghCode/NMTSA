/**
 * Custom hook for authentication
 */

import { useState, useEffect } from 'react';
import { apiClient } from '@/lib/api/client';
import type { User } from '@/types';

interface UseAuthReturn {
  user: User | null;
  isLoading: boolean;
  isAuthenticated: boolean;
  login: (email: string, password: string) => Promise<void>;
  logout: () => Promise<void>;
  register: (email: string, password: string, name: string) => Promise<void>;
}

export function useAuth(): UseAuthReturn {
  const [user, setUser] = useState<User | null>(null);
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    // Check if user is already authenticated
    const token = localStorage.getItem('token');
    if (token) {
      fetchUser();
    } else {
      setIsLoading(false);
    }
  }, []);

  const fetchUser = async () => {
    try {
      const response = await apiClient.get<{ data: User }>('/users/me');
      setUser(response.data);
    } catch {
      localStorage.removeItem('token');
    } finally {
      setIsLoading(false);
    }
  };

  const login = async (email: string, password: string) => {
    try {
      const response = await apiClient.post<{ data: { user: User; token: string } }>(
        '/auth/login',
        { email, password }
      );
      localStorage.setItem('token', response.data.token);
      setUser(response.data.user);
    } catch {
      throw new Error('Login failed');
    }
  };

  const logout = async () => {
    localStorage.removeItem('token');
    setUser(null);
  };

  const register = async (email: string, password: string, name: string) => {
    try {
      const response = await apiClient.post<{ data: { user: User; token: string } }>(
        '/auth/register',
        { email, password, name }
      );
      localStorage.setItem('token', response.data.token);
      setUser(response.data.user);
    } catch {
      throw new Error('Registration failed');
    }
  };

  return {
    user,
    isLoading,
    isAuthenticated: !!user,
    login,
    logout,
    register,
  };
}
