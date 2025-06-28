#!/bin/bash

# Quick Rebuild Script for Fast Iteration
# This script quickly rebuilds and reinstalls your app for rapid testing

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}⚡ Quick Rebuild & Install${NC}"

# Check if device is connected
if ! xcrun devicectl list devices | grep -q "iPhone"; then
    echo -e "${YELLOW}📱 Connect your iPhone and trust this computer${NC}"
    exit 1
fi

DEVICE_ID=$(xcrun devicectl list devices | grep iPhone | head -1 | awk '{print $2}' | sed 's/[()]//g')

echo -e "${YELLOW}🔄 Quick build starting...${NC}"

# Quick build without full clean
cd ios
xcodebuild \
    -workspace exposhadcn.xcworkspace \
    -scheme exposhadcn \
    -configuration Debug \
    -destination generic/platform=iOS \
    build-for-testing \
    CODE_SIGNING_ALLOWED=YES \
    CODE_SIGN_IDENTITY="iPhone Developer"

# Install directly from DerivedData
DERIVED_DATA_PATH=$(xcodebuild -workspace exposhadcn.xcworkspace -scheme exposhadcn -showBuildSettings | grep "BUILD_DIR" | head -1 | awk '{print $3}')
APP_PATH="${DERIVED_DATA_PATH}/Debug-iphoneos/exposhadcn.app"

cd ..

if [ -d "$APP_PATH" ]; then
    echo -e "${YELLOW}📲 Installing app...${NC}"
    xcrun devicectl device install app --device $DEVICE_ID "$APP_PATH"
    echo -e "${GREEN}✅ Quick rebuild complete!${NC}"
else
    echo -e "${YELLOW}⚠️  App not found, running full build...${NC}"
    ./scripts/build-ios-local.sh
fi 