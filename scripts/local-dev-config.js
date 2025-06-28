// Local Development Configuration
// This file contains optimizations for local iOS development

const localDevConfig = {
  // Build optimizations
  build: {
    // Faster builds for development
    minify: false,
    bundleSize: false,
    sourceMap: true,

    // iOS specific optimizations
    ios: {
      // Use development configuration
      buildConfiguration: 'Debug',

      // Skip unnecessary steps for local dev
      skipBundlePatterns: ['**/*.md', '**/docs/**', '**/*.test.*', '**/*.spec.*'],

      // Development signing
      codeSigningStyle: 'automatic',
      developmentTeam: '', // Will be set by Xcode

      // Faster asset processing
      assetOptimization: false,

      // Enable development features
      developmentBuild: true,
      enableDeveloperMenu: true,
      enableRemoteDebugging: true,
    },
  },

  // Metro bundler optimizations for faster rebuilds
  metro: {
    // Cache settings
    cacheStores: [
      {
        name: 'FileStore',
        root: './node_modules/.cache/metro',
      },
    ],

    // Resolver optimizations
    resolver: {
      enableGlobalPackages: true,
      unstable_enableSymlinks: true,
    },

    // Transformer optimizations
    transformer: {
      // Faster minification for development
      minifierConfig: {
        keep_classnames: true,
        keep_fnames: true,
        mangle: false,
      },
    },
  },

  // Development server settings
  devServer: {
    // Local network access
    host: '0.0.0.0',
    port: 8081,

    // Hot reloading
    hot: true,
    liveReload: true,

    // Development middleware
    middleware: ['dev-middleware', 'hot-middleware'],
  },

  // Debugging optimizations
  debugging: {
    // Enable all debugging features
    enableNetworkInspector: true,
    enablePerformanceMonitor: true,
    enableElementInspector: true,

    // Source maps for better debugging
    sourceMaps: {
      enabled: true,
      type: 'source-map',
    },
  },
};

module.exports = localDevConfig;
