/**
 * Error Handling Middleware
 * Centralized error handling for the API
 */

import { NextApiRequest, NextApiResponse } from 'next';

export class ApiError extends Error {
  statusCode: number;
  details?: Record<string, unknown>;

  constructor(message: string, statusCode: number = 500, details?: Record<string, unknown>) {
    super(message);
    this.statusCode = statusCode;
    this.details = details;
    this.name = 'ApiError';
  }
}

export function errorHandler(
  error: Error | ApiError,
  req: NextApiRequest,
  res: NextApiResponse
) {
  console.error('API Error:', error);

  if (error instanceof ApiError) {
    return res.status(error.statusCode).json({
      success: false,
      error: error.message,
      details: error.details,
    });
  }

  // Default to 500 server error
  return res.status(500).json({
    success: false,
    error: 'Internal Server Error',
    message: process.env.NODE_ENV === 'development' ? error.message : undefined,
  });
}

export default errorHandler;
