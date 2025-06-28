#!/bin/bash

# Local iOS Development Setup Script
# This script sets up everything needed for local iOS development without paid Apple Developer account

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🛠️  Setting up Local iOS Development Environment${NC}"

# Check prerequisites
check_prerequisites() {
    echo -e "${YELLOW}🔍 Checking prerequisites...${NC}"
    
    # Check Xcode
    if ! command -v xcodebuild &> /dev/null; then
        echo -e "${RED}❌ Xcode is not installed. Please install Xcode from the App Store.${NC}"
        exit 1
    fi
    
    echo -e "${GREEN}✅ Xcode found: $(xcodebuild -version | head -1)${NC}"
    
    # Check if Xcode command line tools are installed
    if ! xcode-select -p &> /dev/null; then
        echo -e "${YELLOW}📦 Installing Xcode command line tools...${NC}"
        xcode-select --install
        echo -e "${YELLOW}Please complete the installation and run this script again.${NC}"
        exit 0
    fi
    
    echo -e "${GREEN}✅ Xcode command line tools installed${NC}"
    
    # Check Node.js and pnpm
    if ! command -v node &> /dev/null; then
        echo -e "${RED}❌ Node.js is not installed. Please install Node.js.${NC}"
        exit 1
    fi
    
    if ! command -v pnpm &> /dev/null; then
        echo -e "${RED}❌ pnpm is not installed. Please install pnpm.${NC}"
        exit 1
    fi
    
    echo -e "${GREEN}✅ Node.js and pnpm found${NC}"
}

# Setup Apple ID for development
setup_apple_id() {
    echo -e "${YELLOW}🍎 Setting up Apple ID for development...${NC}"
    echo -e "${BLUE}ℹ️  You'll need to add your Apple ID to Xcode manually.${NC}"
    echo -e "${BLUE}📝 Instructions:${NC}"
    echo -e "${BLUE}   1. Open Xcode${NC}"
    echo -e "${BLUE}   2. Go to Xcode > Settings (or Preferences)${NC}"
    echo -e "${BLUE}   3. Click on 'Accounts' tab${NC}"
    echo -e "${BLUE}   4. Click '+' and add your Apple ID${NC}"
    echo -e "${BLUE}   5. Sign in with your free Apple ID${NC}"
    echo -e "${BLUE}   6. Select your Personal Team${NC}"
    
    read -p "Press Enter when you've completed the Apple ID setup in Xcode..."
}

# Configure project for local development
configure_project() {
    echo -e "${YELLOW}⚙️  Configuring project for local development...${NC}"
    
    # Install dependencies
    echo -e "${BLUE}📦 Installing dependencies...${NC}"
    pnpm install
    
    # Prebuild iOS
    echo -e "${BLUE}🏗️  Prebuilding iOS project...${NC}"
    npx expo prebuild --platform ios --clean
    
    # Open iOS project to configure signing
    echo -e "${YELLOW}📱 Opening iOS project in Xcode for signing setup...${NC}"
    open ios/exposhadcn.xcworkspace
    
    echo -e "${BLUE}📝 Configure code signing in Xcode:${NC}"
    echo -e "${BLUE}   1. Select 'exposhadcn' project in navigator${NC}"
    echo -e "${BLUE}   2. Select 'exposhadcn' target${NC}"
    echo -e "${BLUE}   3. Go to 'Signing & Capabilities' tab${NC}"
    echo -e "${BLUE}   4. Check 'Automatically manage signing'${NC}"
    echo -e "${BLUE}   5. Select your Team (Personal Team)${NC}"
    echo -e "${BLUE}   6. Xcode will automatically create provisioning profile${NC}"
    echo -e "${BLUE}   7. Connect your iPhone via USB${NC}"
    echo -e "${BLUE}   8. Trust this computer on your iPhone${NC}"
    echo -e "${BLUE}   9. Select your iPhone in device list${NC}"
    echo -e "${BLUE}   10. Build and run (⌘+R) to test${NC}"
    
    read -p "Press Enter when you've completed the signing setup..."
}

# Make scripts executable
setup_scripts() {
    echo -e "${YELLOW}📜 Setting up build scripts...${NC}"
    chmod +x scripts/build-ios-local.sh
    chmod +x scripts/quick-rebuild.sh
    chmod +x scripts/setup-local-ios.sh
    echo -e "${GREEN}✅ Scripts are now executable${NC}"
}

# Create package.json scripts
update_package_scripts() {
    echo -e "${YELLOW}📄 Adding npm scripts for local development...${NC}"
    
    # Add new scripts to package.json
    node -e "
    const fs = require('fs');
    const pkg = JSON.parse(fs.readFileSync('package.json', 'utf8'));
    pkg.scripts = {
        ...pkg.scripts,
        'ios:build': './scripts/build-ios-local.sh',
        'ios:quick': './scripts/quick-rebuild.sh',
        'ios:setup': './scripts/setup-local-ios.sh'
    };
    fs.writeFileSync('package.json', JSON.stringify(pkg, null, 2));
    "
    
    echo -e "${GREEN}✅ Package.json updated with iOS scripts${NC}"
}

# Create reminder script for 7-day expiry
create_reminder() {
    cat > scripts/reminder.sh << 'EOF'
#!/bin/bash

# App Expiry Reminder
echo "🚨 REMINDER: Your iOS app will expire in 7 days from build date"
echo "📅 Last build: $(date)"
echo "🔄 Run 'pnpm ios:build' to rebuild when the app expires"
echo "⚡ Run 'pnpm ios:quick' for quick rebuilds during development"

# Add to calendar (macOS)
osascript -e "tell application \"Calendar\" to make new event at end of events of calendar \"Personal\" with properties {summary:\"Rebuild iOS App\", start date:(current date) + 6 * days, end date:(current date) + 6 * days + 1 * hours}" 2>/dev/null || true
EOF

    chmod +x scripts/reminder.sh
    echo -e "${GREEN}✅ Reminder script created${NC}"
}

# Main setup function
main() {
    echo -e "${BLUE}======================================${NC}"
    echo -e "${BLUE}   Local iOS Development Setup       ${NC}"
    echo -e "${BLUE}======================================${NC}"
    
    check_prerequisites
    setup_apple_id
    configure_project
    setup_scripts
    update_package_scripts
    create_reminder
    
    echo -e "${GREEN}🎉 Local iOS development environment setup complete!${NC}"
    echo -e "${BLUE}📚 Quick Start Commands:${NC}"
    echo -e "${BLUE}   pnpm ios:build  - Full build and install${NC}"
    echo -e "${BLUE}   pnpm ios:quick  - Quick rebuild for iteration${NC}"
    echo -e "${YELLOW}💡 Remember: Apps expire after 7 days with free Apple ID${NC}"
    echo -e "${YELLOW}🔄 Rebuild weekly or when the app stops working${NC}"
}

main "$@" 