# API Documentation

## Base URL

```
Development: http://localhost:3000/api
Production: https://your-domain.com/api
```

## Authentication

Most endpoints require authentication using JWT tokens.

Include the token in the Authorization header:
```
Authorization: Bearer <your-jwt-token>
```

## Endpoints

### Health Check

**GET** `/api/health`

Check if the API is running.

**Response:**
```json
{
  "success": true,
  "message": "API is running",
  "timestamp": "2025-11-02T00:00:00.000Z"
}
```

---

### Authentication

#### Register User

**POST** `/api/auth/register`

Create a new user account.

**Request Body:**
```json
{
  "email": "user@example.com",
  "password": "SecurePassword123!",
  "name": "John Doe"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "user": {
      "id": "user-id",
      "email": "user@example.com",
      "name": "John Doe"
    },
    "token": "jwt-token"
  }
}
```

#### Login

**POST** `/api/auth/login`

Authenticate and receive a JWT token.

**Request Body:**
```json
{
  "email": "user@example.com",
  "password": "SecurePassword123!"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "user": {
      "id": "user-id",
      "email": "user@example.com",
      "name": "John Doe"
    },
    "token": "jwt-token"
  }
}
```

---

### Users

#### Get Current User

**GET** `/api/users/me`

Get the authenticated user's profile.

**Headers:**
```
Authorization: Bearer <token>
```

**Response:**
```json
{
  "success": true,
  "data": {
    "id": "user-id",
    "email": "user@example.com",
    "name": "John Doe",
    "role": "user",
    "createdAt": "2025-01-01T00:00:00.000Z"
  }
}
```

#### Update User

**PUT** `/api/users/me`

Update the authenticated user's profile.

**Headers:**
```
Authorization: Bearer <token>
```

**Request Body:**
```json
{
  "name": "John Updated",
  "email": "newemail@example.com"
}
```

---

## Error Responses

All error responses follow this format:

```json
{
  "success": false,
  "error": "Error message",
  "statusCode": 400
}
```

### Common Status Codes

- `200` - Success
- `201` - Created
- `400` - Bad Request
- `401` - Unauthorized
- `403` - Forbidden
- `404` - Not Found
- `500` - Internal Server Error

## Rate Limiting

API requests are rate-limited to prevent abuse:
- Development: 100 requests per minute
- Production: 60 requests per minute

## Pagination

Endpoints that return lists support pagination:

**Query Parameters:**
- `page` - Page number (default: 1)
- `limit` - Items per page (default: 10, max: 100)
- `sortBy` - Field to sort by
- `sortOrder` - Sort direction (`asc` or `desc`)

**Example:**
```
GET /api/users?page=1&limit=20&sortBy=createdAt&sortOrder=desc
```

**Response:**
```json
{
  "success": true,
  "data": [...],
  "pagination": {
    "page": 1,
    "limit": 20,
    "total": 100,
    "totalPages": 5
  }
}
```

## WebSocket (Future)

Real-time updates will be available via WebSocket connection:

```javascript
const ws = new WebSocket('wss://your-domain.com/ws');

ws.onmessage = (event) => {
  const data = JSON.parse(event.data);
  // Handle real-time update
};
```

## SDK (Future)

Official SDKs will be available for:
- JavaScript/TypeScript
- Python
- Go
