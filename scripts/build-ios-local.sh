#!/bin/bash

# Local iOS Build Script for Free Apple ID
# This script builds and installs your iOS app locally without paid developer account

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Starting Local iOS Build Process${NC}"

# Check if device is connected
check_device() {
    echo -e "${YELLOW}📱 Checking for connected iOS device...${NC}"
    
    if xcrun devicectl list devices | grep -q "iPhone"; then
        echo -e "${GREEN}✅ iOS device found!${NC}"
        DEVICE_ID=$(xcrun devicectl list devices | grep iPhone | head -1 | awk '{print $2}' | sed 's/[()]//g')
        echo -e "${BLUE}Device ID: $DEVICE_ID${NC}"
    else
        echo -e "${RED}❌ No iOS device connected. Please connect your iPhone via USB.${NC}"
        exit 1
    fi
}

# Clean previous builds
clean_build() {
    echo -e "${YELLOW}🧹 Cleaning previous builds...${NC}"
    rm -rf ios/build
    rm -rf ios/DerivedData
    cd ios && xcodebuild clean -workspace exposhadcn.xcworkspace -scheme exposhadcn && cd ..
}

# Fix code signing issues
fix_code_signing() {
    echo -e "${YELLOW}🔧 Checking code signing configuration...${NC}"
    
    # Check if we have signing issues and apply fix
    if ! xcodebuild -workspace ios/exposhadcn.xcworkspace -scheme exposhadcn -configuration Debug -destination generic/platform=iOS build -quiet 2>/dev/null; then
        echo -e "${YELLOW}⚠️  Code signing issues detected, applying fix...${NC}"
        ./scripts/fix-code-signing.sh
    else
        echo -e "${GREEN}✅ Code signing OK${NC}"
    fi
}

# Build the app
build_app() {
    echo -e "${YELLOW}🔨 Building iOS app...${NC}"
    
    cd ios
    
    # Build for device
    xcodebuild \
        -workspace exposhadcn.xcworkspace \
        -scheme exposhadcn \
        -configuration Debug \
        -destination generic/platform=iOS \
        -archivePath ./build/exposhadcn.xcarchive \
        archive \
        CODE_SIGNING_ALLOWED=YES \
        CODE_SIGNING_REQUIRED=YES \
        CODE_SIGN_IDENTITY="iPhone Developer" \
        DEVELOPMENT_TEAM="" \
        PROVISIONING_PROFILE_SPECIFIER=""
    
    # Export the archive
    xcodebuild \
        -exportArchive \
        -archivePath ./build/exposhadcn.xcarchive \
        -exportPath ./build \
        -exportOptionsPlist ../scripts/ExportOptions.plist
    
    cd ..
    
    echo -e "${GREEN}✅ Build completed successfully!${NC}"
}

# Install on device
install_app() {
    echo -e "${YELLOW}📲 Installing app on device...${NC}"
    
    # Find the .ipa file
    IPA_FILE=$(find ios/build -name "*.ipa" | head -1)
    
    if [ -z "$IPA_FILE" ]; then
        echo -e "${RED}❌ No .ipa file found. Build may have failed.${NC}"
        exit 1
    fi
    
    echo -e "${BLUE}Installing: $IPA_FILE${NC}"
    
    # Install using xcrun devicectl
    xcrun devicectl device install app --device $DEVICE_ID "$IPA_FILE"
    
    echo -e "${GREEN}✅ App installed successfully!${NC}"
}

# Main execution
main() {
    echo -e "${BLUE}======================================${NC}"
    echo -e "${BLUE}  Local iOS Build & Install Script   ${NC}"
    echo -e "${BLUE}======================================${NC}"
    
    check_device
    clean_build
    fix_code_signing
    build_app
    install_app
    
    echo -e "${GREEN}🎉 Local iOS build and install completed!${NC}"
    echo -e "${YELLOW}💡 Remember: Apps built with free Apple ID expire after 7 days${NC}"
    echo -e "${YELLOW}💡 Re-run this script weekly to refresh the app${NC}"
}

# Run main function
main "$@" 