# ESLint Configuration for Expo React Native TypeScript Project

This project has been configured with a comprehensive ESLint setup optimized for Expo React Native development with TypeScript.

## 🚀 What's Included

### Core ESLint Configuration

- **eslint-config-expo**: Official Expo ESLint configuration with React Native support
- **Modern Flat Config**: Uses the latest ESLint flat configuration format (`eslint.config.js`)
- **TypeScript Support**: Full TypeScript linting with `@typescript-eslint/parser` and `@typescript-eslint/eslint-plugin`
- **React Hooks Support**: Enforces React hooks rules with `eslint-plugin-react-hooks`
- **Import Organization**: Automatic import sorting and organization with `eslint-plugin-import`

### Prettier Integration

- **Automatic Code Formatting**: Prettier integration for consistent code style
- **Format on Save**: VSCode workspace configured for auto-formatting
- **Conflict Resolution**: ESLint and Prettier configured to work together seamlessly

### VSCode Integration

- **Real-time Linting**: ESLint errors and warnings shown in editor
- **Auto-fix on Save**: Automatically fixes ESLint issues when saving files
- **Import Organization**: Automatically organizes imports on save
- **Extension Recommendations**: Project includes recommended VSCode extensions

## 📁 Configuration Files

### `eslint.config.js`

Modern flat configuration with:

- Base Expo configuration
- Enhanced rules for code quality
- TypeScript-specific rules
- Prettier integration
- File ignores for build artifacts

### `.prettierrc`

Prettier configuration optimized for React Native:

```json
{
  "printWidth": 100,
  "tabWidth": 2,
  "useTabs": false,
  "semi": true,
  "singleQuote": true,
  "quoteProps": "as-needed",
  "jsxSingleQuote": true,
  "trailingComma": "es5",
  "bracketSpacing": true,
  "bracketSameLine": false,
  "arrowParens": "avoid",
  "endOfLine": "lf",
  "embeddedLanguageFormatting": "auto"
}
```

### `.vscode/settings.json`

VSCode workspace settings for optimal development experience:

- Auto-format on save with Prettier
- Auto-fix ESLint issues on save
- Organize imports automatically
- TypeScript auto-import preferences

### `.vscode/extensions.json`

Recommended VSCode extensions:

- ESLint
- Prettier
- TypeScript
- Tailwind CSS IntelliSense
- Expo Tools
- React Native Tools

## 🛠 Available Scripts

```bash
# Lint all files
pnpm lint

# Lint and auto-fix issues
pnpm lint:fix

# Format all files with Prettier
pnpm format

# Check if files are formatted correctly
pnpm format:check

# Run TypeScript type checking
pnpm type-check

# Run all checks (TypeScript + ESLint + Prettier)
pnpm check-all
```

## 🎯 Key Rules and Features

### Code Quality Rules

- **No unused variables**: Enforced with TypeScript-specific rules
- **Prefer const**: Encourages immutable variable declarations
- **No var**: Modern ES6+ syntax enforcement
- **Object shorthand**: Cleaner object notation
- **Template literals**: Prefer template strings over concatenation

### React-Specific Rules

- **Hooks rules**: Enforces proper React hooks usage
- **No prop-types**: Disabled since TypeScript handles type checking
- **JSX quotes**: Consistent single quotes in JSX
- **No unescaped entities**: Allows quotes in JSX text

### Import Organization

Imports are automatically organized into groups:

1. Built-in modules (Node.js modules)
2. External packages (from node_modules)
3. Internal modules (project modules)
4. Parent directory imports
5. Sibling file imports
6. Index file imports

Each group is alphabetically sorted and separated by empty lines.

### TypeScript Rules

- **Strict type checking**: Enforces proper TypeScript usage
- **Optional chaining**: Prefers optional chaining operator
- **Nullish coalescing**: Prefers nullish coalescing operator
- **No explicit any**: Warns about explicit `any` usage
- **No unnecessary assertions**: Prevents redundant type assertions

## 🔧 Customization

### Adding New Rules

To add custom rules, edit `eslint.config.js`:

```javascript
// In the rules section
rules: {
  'your-custom-rule': 'error',
  // ... other rules
}
```

### Disabling Rules

To disable specific rules for files or lines:

```javascript
// Disable for entire file
/* eslint-disable rule-name */

// Disable for next line
// eslint-disable-next-line rule-name

// Disable for specific line
const code = 'here'; // eslint-disable-line rule-name
```

### Ignoring Files

Add patterns to the `ignores` array in `eslint.config.js`:

```javascript
{
  ignores: [
    'your-folder/**',
    'specific-file.js',
    // ... other patterns
  ];
}
```

## 🚨 Common Issues and Solutions

### ESLint Warnings about `.eslintignore`

This is expected - flat config uses the `ignores` property instead of `.eslintignore` files.

### Import Order Issues

Run `pnpm lint:fix` to automatically fix import ordering issues.

### Prettier Conflicts

The configuration ensures Prettier and ESLint work together. If you see conflicts, run `pnpm format` followed by `pnpm lint:fix`.

### VSCode Not Auto-fixing

1. Ensure you have the ESLint and Prettier VSCode extensions installed
2. Check that the workspace settings are being applied
3. Restart the ESLint server: `Cmd+Shift+P` → "ESLint: Restart ESLint Server"

## 📚 Best Practices

1. **Run checks before committing**:

   ```bash
   pnpm check-all
   ```

2. **Use auto-fix for routine issues**:

   ```bash
   pnpm lint:fix
   ```

3. **Format before reviewing**:

   ```bash
   pnpm format
   ```

4. **Set up pre-commit hooks** (recommended):
   Consider using Husky and lint-staged for automatic checks before commits.

## 🔄 Maintenance

### Updating Dependencies

Regularly update ESLint and related packages:

```bash
pnpm update eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin eslint-config-expo prettier
```

### Checking for New Rules

ESLint configurations are regularly updated. Check the official documentation for new recommended rules and update your configuration accordingly.

## 🎉 Benefits of This Setup

1. **Consistent Code Style**: Enforced across the entire project
2. **Bug Prevention**: Catches common errors before runtime
3. **Better Developer Experience**: Real-time feedback in VSCode
4. **Team Collaboration**: Standardized formatting and linting rules
5. **Maintainable Codebase**: Cleaner, more readable code
6. **TypeScript Integration**: Full type safety with linting support
7. **React Native Optimized**: Configured specifically for React Native development

This setup provides a solid foundation for maintaining high code quality in your Expo React Native TypeScript project!
