# Budget Tracker - Claude Assistant Guide

## Build Commands
- `npm start` - Run development server
- `npm run build` - Build production bundle
- `npm test` - Run all tests
- `npm test -- --testPathPattern=App` - Run specific test file
- `npm test -- --watch` - Run tests in watch mode

## Lint/Format
- `npx eslint src/` - Lint source files
- `npx prettier --write src/` - Format source files

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

## Project Structure
This is a Create React App PWA TypeScript project.