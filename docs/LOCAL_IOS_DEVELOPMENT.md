# 🚀 Local iOS Development Setup

Complete guide for developing and testing iOS apps locally without a paid Apple Developer Program membership.

## 📋 Overview

This setup allows you to:

- ✅ Build and install iOS apps on your personal device
- ✅ Use only a free Apple ID (no $99/year fee)
- ✅ Work completely offline after initial setup
- ✅ Iterate quickly with fast rebuild scripts
- ✅ Bypass Expo Go server dependencies

## ⚠️ Important Limitations

With a **free Apple ID**:

- 📅 Apps expire after **7 days** and need rebuilding
- 📱 Limited to **3 registered devices**
- 🔢 Maximum **10 App IDs** per week
- 🚫 No TestFlight distribution
- 🚫 No advanced iOS capabilities

## 🛠️ Prerequisites

- **macOS** with Xcode 12+ installed
- **iPhone** with iOS 13+ and USB cable
- **Free Apple ID** account
- **Node.js** and **pnpm** installed

## 🚀 Quick Start

### 1. Initial Setup (One-time)

Run the automated setup script:

```bash
./scripts/setup-local-ios.sh
```

This will:

- ✅ Check all prerequisites
- ✅ Guide you through Apple ID setup in Xcode
- ✅ Configure project for local development
- ✅ Set up automated build scripts

### 2. First Build & Install

```bash
# Full build and install on your iPhone
pnpm ios:build
```

### 3. Quick Development Iteration

```bash
# Quick rebuild for fast iteration (30 seconds vs 5 minutes)
pnpm ios:quick
```

## 📱 Device Setup

### Connect Your iPhone

1. **Connect via USB cable**
2. **Unlock your iPhone**
3. **Trust this computer** when prompted
4. **Keep iPhone unlocked** during builds

### Verify Connection

```bash
xcrun devicectl list devices
```

Should show your iPhone in the list.

## 🔧 Manual Xcode Configuration

If the automated setup needs manual intervention:

### Add Apple ID to Xcode

1. Open **Xcode**
2. Go to **Xcode → Settings → Accounts**
3. Click **"+"** and sign in with your **free Apple ID**
4. Select your **Personal Team**

### Configure Code Signing

1. Open `ios/exposhadcn.xcworkspace` in Xcode
2. Select **"exposhadcn"** project in navigator
3. Select **"exposhadcn"** target
4. Go to **"Signing & Capabilities"** tab
5. Check **"Automatically manage signing"**
6. Select your **Team** (Personal Team)
7. Xcode creates provisioning profile automatically

## ⚡ Development Workflow

### Daily Development

```bash
# Start development server
pnpm dev

# Make code changes...

# Quick rebuild and install
pnpm ios:quick
```

### Weekly Maintenance

```bash
# When app expires (every 7 days)
pnpm ios:build
```

### Build Scripts Explained

| Command          | Purpose                     | Time    | Use Case                    |
| ---------------- | --------------------------- | ------- | --------------------------- |
| `pnpm ios:build` | Full clean build & install  | ~5 min  | First build, weekly refresh |
| `pnpm ios:quick` | Incremental build & install | ~30 sec | Daily development iteration |

## 🏗️ Alternative: EAS Build Without Paid Account

While EAS Build typically requires a paid Apple Developer account for iOS, you can use it for Android builds and Expo Go development:

```bash
# Build for Android (no Apple account needed)
eas build --platform android --profile development

# For iOS simulator (no device deployment)
eas build --platform ios --profile development --local
```

**Note**: EAS Build for iOS device deployment requires paid Apple Developer membership.

## 🔍 Troubleshooting

### Common Issues

#### "No signing identity found"

```bash
# Solution: Add Apple ID to Xcode accounts
open ios/exposhadcn.xcworkspace
# Follow signing setup in Xcode
```

#### "Device not found"

```bash
# Solution: Check iPhone connection
xcrun devicectl list devices

# Reconnect iPhone, trust computer
```

#### "Provisioning profile expired"

```bash
# Solution: Rebuild (happens every 7 days)
pnpm ios:build
```

#### Build failures

```bash
# Clean build cache
cd ios
xcodebuild clean -workspace exposhadcn.xcworkspace -scheme exposhadcn
cd ..

# Rebuild
pnpm ios:build
```

### Advanced Troubleshooting

#### Clear all certificates

```bash
# Remove all provisioning profiles
rm -rf ~/Library/MobileDevice/Provisioning\ Profiles/*

# Rebuild and reconfigure
pnpm ios:build
```

#### Reset development environment

```bash
# Clean everything
rm -rf ios/build
rm -rf ios/DerivedData
rm -rf node_modules
pnpm install
npx expo prebuild --platform ios --clean
```

## 📊 Performance Optimization

### Build Speed Tips

1. **Use quick rebuild** for iteration (`pnpm ios:quick`)
2. **Keep Xcode open** to avoid startup time
3. **Use SSD storage** for faster I/O
4. **Close unnecessary apps** to free RAM
5. **Use latest Xcode** for optimization improvements

### Development Tips

1. **Test frequently** with quick rebuilds
2. **Use iOS Simulator** for UI work (no device limits)
3. **Keep iPhone connected** to avoid USB setup time
4. **Use Xcode debugger** for serious debugging

## 🔄 Automation & Reminders

### Automated Expiry Reminders

The setup creates a calendar reminder 6 days after each build:

```bash
# Manual reminder check
./scripts/reminder.sh
```

### Cron Job for Weekly Builds

Add to crontab for automatic weekly rebuilds:

```bash
# Edit crontab
crontab -e

# Add weekly rebuild (Sundays at 2 AM)
0 2 * * 0 cd /path/to/your/expo-shadcn && pnpm ios:build
```

## 🆚 Comparison: Free vs Paid

| Feature                   | Free Apple ID     | Paid Developer ($99/year) |
| ------------------------- | ----------------- | ------------------------- |
| **Device installation**   | ✅ (7-day expiry) | ✅ (1-year validity)      |
| **Device limit**          | 3 devices         | 100 devices               |
| **TestFlight**            | ❌                | ✅                        |
| **App Store**             | ❌                | ✅                        |
| **Advanced capabilities** | ❌                | ✅                        |
| **Background processing** | Limited           | Full                      |
| **Push notifications**    | Limited           | Full                      |
| **Development ease**      | Weekly rebuilds   | Set and forget            |

## 📚 Additional Resources

- [Apple Developer Documentation](https://developer.apple.com/documentation/)
- [Expo Local Development](https://docs.expo.dev/guides/local-app-development/)
- [Xcode Code Signing Guide](https://help.apple.com/xcode/mac/current/#/dev60b6fbbc7)

## 🤝 Contributing

Found an issue or improvement? Feel free to:

1. Report bugs in project issues
2. Suggest workflow improvements
3. Share optimization tips

---

**💡 Pro Tip**: Set up the automated reminder system and you'll never forget to rebuild your app before it expires!
