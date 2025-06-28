# Expo ShadCN Starter

A modern Expo React Native starter template with TypeScript, NativeWind (Tailwind CSS), and comprehensive development tooling. Built with `react-native-reusables` components and optimized for high-quality development.

## 🚀 Features

### UI & Styling

- **NativeWind v4**: Tailwind CSS for React Native
- **Dark and light mode**: Complete theme support
  - Android Navigation Bar matches mode
  - Persistent mode across app restarts
- **ShadCN-style components**: Pre-built, customizable UI components
  - ThemeToggle, Avatar, Button, Card, Progress, Text, Tooltip

### Development Tooling

- **TypeScript**: Full type safety with strict configuration
- **ESLint**: Comprehensive linting with Expo + React Native rules
- **Prettier**: Automatic code formatting
- **VSCode Integration**: Optimized workspace settings and extensions
- **Import Organization**: Automatic import sorting and grouping

## 🛠 Development Scripts

```bash
# Development
pnpm dev              # Start Expo development server
pnpm dev:android      # Start with Android focus
pnpm dev:ios          # Start with iOS focus
pnpm dev:web          # Start web version

# Code Quality
pnpm lint             # Run ESLint
pnpm lint:fix         # Auto-fix ESLint issues
pnpm format           # Format code with Prettier
pnpm format:check     # Check formatting
pnpm type-check       # TypeScript type checking
pnpm check-all        # Run all checks (types + lint + format)

# Utilities
pnpm clean            # Clean build artifacts
```

## 📚 Documentation

- [ESLint Setup Guide](./docs/ESLINT_SETUP.md) - Comprehensive guide to the linting configuration

## 🎨 Preview

<img src="https://github.com/mrzachnugent/react-native-reusables/assets/63797719/42c94108-38a7-498b-9c70-18640420f1bc"
     alt="starter-base-template"
     style="width:270px;" />

## 🏗 Project Structure

```
├── app/                    # Expo Router app directory
│   ├── _layout.tsx        # Root layout with theme provider
│   ├── index.tsx          # Home screen
│   └── +not-found.tsx     # 404 page
├── components/            # Reusable UI components
│   ├── ui/               # Base UI components (shadcn-style)
│   └── ThemeToggle.tsx   # Theme switching component
├── lib/                  # Utilities and helpers
│   ├── icons/           # Icon components
│   ├── constants.ts     # App constants
│   ├── utils.ts         # Utility functions
│   └── useColorScheme.tsx # Theme hook
├── docs/                # Project documentation
├── .vscode/            # VSCode workspace settings
├── eslint.config.js    # ESLint configuration
├── .prettierrc         # Prettier configuration
├── tailwind.config.js  # Tailwind CSS configuration
└── tsconfig.json       # TypeScript configuration
```

## 🚦 Getting Started

1. **Install dependencies**:

   ```bash
   pnpm install
   ```

2. **Start development server**:

   ```bash
   pnpm dev
   ```

3. **Install recommended VSCode extensions** (optional but recommended):
   - Open VSCode in the project directory
   - Install the recommended extensions when prompted

4. **Verify setup**:
   ```bash
   pnpm check-all
   ```

## 💡 Best Practices

- Run `pnpm check-all` before committing changes
- Use `pnpm lint:fix` to automatically fix linting issues
- Format code with `pnpm format` for consistency
- Follow the established import organization patterns

## 🔧 Customization

This starter is designed to be easily customizable:

- **Theme**: Modify colors in `lib/constants.ts` and `tailwind.config.js`
- **Components**: Extend or modify components in `components/ui/`
- **ESLint Rules**: Customize linting rules in `eslint.config.js`
- **Prettier Config**: Adjust formatting in `.prettierrc`

## 🤝 Contributing

This project follows strict code quality standards:

1. All code must pass TypeScript compilation
2. ESLint rules must be followed (auto-fixable issues will be handled automatically)
3. Code must be formatted with Prettier
4. Imports should be organized automatically by the tooling
