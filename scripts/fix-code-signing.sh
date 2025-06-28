#!/bin/bash

# Fix Code Signing for All Targets
# This script resolves the "requires a development team" error

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🔧 Fixing Code Signing Issues${NC}"

# Check if we're in the right directory
if [ ! -d "ios" ]; then
    echo -e "${RED}❌ No iOS directory found. Run from project root.${NC}"
    exit 1
fi

echo -e "${YELLOW}📝 Updating Podfile with code signing fix...${NC}"

# Add post_install hook to Podfile if it doesn't exist
if ! grep -q "post_install" ios/Podfile; then
    cat >> ios/Podfile << 'EOF'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['CODE_SIGNING_REQUIRED'] = 'NO'
      config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
    end
  end
end
EOF
    echo -e "${GREEN}✅ Added post_install hook to Podfile${NC}"
else
    echo -e "${BLUE}ℹ️  Podfile already has post_install hook${NC}"
fi

echo -e "${YELLOW}🧹 Cleaning and reinstalling pods...${NC}"

cd ios
rm -rf Pods/
rm -rf build/
rm Podfile.lock 2>/dev/null || true

pod install

cd ..

echo -e "${GREEN}🎉 Code signing fix applied!${NC}"
echo -e "${BLUE}🚀 Now try: pnpm ios:build${NC}" 