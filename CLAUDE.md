# Budget Tracker - Claude Assistant Guide

## Monorepo Structure
- `Frontend/`: React TypeScript PWA application
- `Database/`: Database services and schema

## Build Commands
- `npm start` - Run development server (Frontend)
- `npm run build` - Build production bundle (Frontend)
- `npm test` - Run all tests
- `npm test -- --testPathPattern=App` - Run specific Frontend test file
- `npm test -- --watch` - Run tests in watch mode

## Lint/Format
- `npx eslint Frontend/src/` - Lint Frontend source files
- `npx prettier --write Frontend/src/ Database/` - Format all source files

## Code Style Guidelines
- **TypeScript**: Use explicit types, avoid `any`, prefer interfaces over types
- **Imports**: Group imports by: (1) React/libraries (2) components (3) styles
- **Naming**: 
  - Components: PascalCase
  - Functions: camelCase
  - Files: Component files match component name
- **Error Handling**: Use try/catch with specific error messaging
- **Components**: Functional components with React hooks
- **State Management**: Use React Context for global state

## Project Architecture
Monorepo with separate Frontend (React TypeScript PWA) and Database packages.