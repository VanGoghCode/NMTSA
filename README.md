# NMTSA - Next.js Modern TypeScript Application

[![Next.js](https://img.shields.io/badge/Next.js-16.0.1-black)](https://nextjs.org/)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.0-blue)](https://www.typescriptlang.org/)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)

A production-ready, industry-level Next.js application with comprehensive folder structure for Frontend, Backend, APIs, and AWS automation.

## 📋 Table of Contents

- [Features](#-features)
- [Tech Stack](#-tech-stack)
- [Getting Started](#-getting-started)
- [Project Structure](#-project-structure)
- [Development](#-development)
- [Deployment](#-deployment)
- [Documentation](#-documentation)
- [Contributing](#-contributing)

## ✨ Features

- 🎯 **Modern Architecture** - Industry-standard folder organization
- 🔐 **Authentication Ready** - JWT-based authentication structure
- 🚀 **AWS Integration** - AWS Amplify Hosting for automated deployments
- 📱 **Responsive Design** - Mobile-first approach with Tailwind CSS
- 🔧 **Type Safety** - Full TypeScript support with strict mode
- 📊 **API Ready** - Structured backend with controllers, services, and middleware
- 🧪 **Test Ready** - Organized test structure (unit, integration, e2e)
- 📦 **Modular Design** - Separation of concerns with clear boundaries
- 🔄 **CI/CD Ready** - GitHub Actions workflow included
- 📚 **Well Documented** - Comprehensive documentation

## 🛠 Tech Stack

### Frontend
- **Framework:** Next.js 16.0.1 (App Router)
- **Language:** TypeScript 5.x
- **Styling:** Tailwind CSS 4.x
- **State Management:** (Ready for Redux/Zustand)

### Backend
- **API:** Next.js API Routes
- **Database:** (PostgreSQL/MongoDB ready)
- **Authentication:** JWT

### Infrastructure
- **Hosting:** AWS Amplify
- **CI/CD:** GitHub Actions

## 🚀 Getting Started

### Prerequisites

- Node.js 20.9.0+ installed (required for Next.js 16)
- npm or yarn package manager
- AWS CLI (for deployment)
- Git

### Installation

1. **Clone the repository**
   ```powershell
   git clone https://github.com/VanGoghCode/NMTSA.git
   cd NMTSA
   ```

2. **Install dependencies**
   ```powershell
   .\scripts\setup\install-dependencies.ps1
   # or
   npm install
   ```

3. **Configure environment variables**
   ```powershell
   Copy-Item .env.example .env
   # Edit .env with your configuration
   ```

4. **Run development server**
   ```powershell
   npm run dev
   ```

5. **Open your browser**
   Navigate to [http://localhost:3000](http://localhost:3000)

## 📁 Project Structure

```
nmtsa/
├── app/                    # Next.js App Router
├── src/                    # Frontend source code
│   ├── components/        # React components
│   ├── hooks/            # Custom hooks
│   ├── lib/              # Core libraries & API client
│   ├── types/            # TypeScript definitions
│   ├── config/           # Frontend configuration
│   └── services/         # Business logic services
├── server/                # Backend server code
│   ├── api/              # API routes
│   ├── controllers/      # Request controllers
│   ├── models/           # Data models
│   ├── services/         # Business logic
│   ├── middleware/       # Middleware functions
│   └── config/           # Server configuration
├── scripts/               # Automation scripts
│   ├── deploy/           # Deployment automation
│   ├── db/               # Database scripts
│   └── setup/            # Setup scripts
├── tests/                 # Test files
│   ├── unit/             # Unit tests
│   ├── integration/      # Integration tests
│   └── e2e/              # End-to-end tests
└── docs/                  # Documentation
```

For detailed structure, see [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md)

## 💻 Development

### Available Scripts

```powershell
# Development
npm run dev              # Start development server
npm run build            # Build for production
npm run start            # Start production server
npm run lint             # Run ESLint

# Deployment
.\scripts\deploy\deploy.ps1 -Environment production
```

### Code Style

- Follow TypeScript strict mode
- Use ESLint for code quality
- Follow conventional commits
- Write self-documenting code

## 🌐 Deployment

### AWS Amplify Hosting

This project uses AWS Amplify Hosting for automated deployments. Deployments are triggered automatically on push to the main branch via the `amplify.yml` configuration.

### Manual Deployment

```powershell
# Deploy using the deployment script
.\scripts\deploy\deploy.ps1 -Environment production
```

For detailed deployment instructions, see [docs/DEPLOYMENT.md](docs/DEPLOYMENT.md)

## 📚 Documentation

- [Architecture](docs/ARCHITECTURE.md) - System architecture overview
- [API Documentation](docs/API.md) - API endpoints and usage
- [Deployment Guide](docs/DEPLOYMENT.md) - Deployment instructions
- [Project Structure](PROJECT_STRUCTURE.md) - Detailed folder structure

### Development Workflow

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'feat: add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License.

## 👥 Authors

- VanGoghCode - Initial work

## 🙏 Acknowledgments

- Built with [Next.js](https://nextjs.org/)
- Hosted on [AWS Amplify](https://aws.amazon.com/amplify/)

## 📞 Support

For support, please open an issue in the GitHub repository.

---

Made with ❤️ by Kirtankumar Thummar
