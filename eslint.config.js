// https://docs.expo.dev/guides/using-eslint/
const { defineConfig } = require('eslint/config');
const expoConfig = require('eslint-config-expo/flat');
const eslintPluginPrettierRecommended = require('eslint-plugin-prettier/recommended');

module.exports = defineConfig([
  // Base Expo configuration
  expoConfig,

  // Enhanced configuration
  {
    plugins: {
      'react-hooks': require('eslint-plugin-react-hooks'),
    },
    rules: {
      // React Hooks rules
      'react-hooks/rules-of-hooks': 'error',
      'react-hooks/exhaustive-deps': 'warn',

      // Import organization (plugin already available from Expo config)
      'import/order': [
        'error',
        {
          groups: ['builtin', 'external', 'internal', 'parent', 'sibling', 'index'],
          'newlines-between': 'always',
          alphabetize: {
            order: 'asc',
            caseInsensitive: true,
          },
        },
      ],
      'import/no-unresolved': 'off', // Metro resolver handles this
      'import/prefer-default-export': 'off',

      // General code quality
      'no-console': 'warn',
      'no-debugger': 'error',
      'no-unused-vars': 'off', // TypeScript handles this

      // React rules
      'react/prop-types': 'off', // TypeScript handles prop validation
      'react/react-in-jsx-scope': 'off', // Not needed with modern React
      'react/jsx-uses-react': 'off', // Not needed with modern React
      'react/display-name': 'off',
      'react/jsx-props-no-spreading': 'off',
      'react/no-unescaped-entities': 'off', // Allow quotes in JSX

      // Stylistic preferences
      'prefer-const': 'error',
      'no-var': 'error',
      'object-shorthand': 'error',
      'prefer-template': 'error',
    },
  },

  // TypeScript specific configuration
  {
    files: ['**/*.{ts,tsx}'],
    languageOptions: {
      parser: require('@typescript-eslint/parser'),
      parserOptions: {
        project: './tsconfig.json',
        ecmaFeatures: {
          jsx: true,
        },
      },
    },
    plugins: {
      '@typescript-eslint': require('@typescript-eslint/eslint-plugin'),
    },
    rules: {
      // TypeScript specific rules
      '@typescript-eslint/no-unused-vars': [
        'error',
        {
          argsIgnorePattern: '^_',
          varsIgnorePattern: '^_',
        },
      ],
      '@typescript-eslint/no-explicit-any': 'warn',
      '@typescript-eslint/explicit-function-return-type': 'off',
      '@typescript-eslint/explicit-module-boundary-types': 'off',
      '@typescript-eslint/no-non-null-assertion': 'warn',
      '@typescript-eslint/prefer-optional-chain': 'error',
      '@typescript-eslint/prefer-nullish-coalescing': 'error',
      '@typescript-eslint/no-unnecessary-type-assertion': 'error',
    },
  },

  // Prettier integration
  eslintPluginPrettierRecommended,

  // Enhanced ignores
  {
    ignores: [
      'dist/*',
      '.expo/**',
      'node_modules/**',
      'build/**',
      'web-build/**',
      'ios/**',
      'android/**',
      '*.config.js',
      '*.config.ts',
      'babel.config.js',
      'metro.config.js',
      'tailwind.config.js',
    ],
  },
]);
