#!/bin/bash

# Test Local iOS Development Workflow
# This script tests the complete setup and provides feedback

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🧪 Testing Local iOS Development Workflow${NC}"

# Test 1: Check prerequisites
test_prerequisites() {
    echo -e "${YELLOW}🔍 Test 1: Checking prerequisites...${NC}"
    
    local errors=0
    
    # Check Xcode
    if ! command -v xcodebuild &> /dev/null; then
        echo -e "${RED}❌ Xcode not found${NC}"
        ((errors++))
    else
        echo -e "${GREEN}✅ Xcode: $(xcodebuild -version | head -1)${NC}"
    fi
    
    # Check Node.js
    if ! command -v node &> /dev/null; then
        echo -e "${RED}❌ Node.js not found${NC}"
        ((errors++))
    else
        echo -e "${GREEN}✅ Node.js: $(node --version)${NC}"
    fi
    
    # Check pnpm
    if ! command -v pnpm &> /dev/null; then
        echo -e "${RED}❌ pnpm not found${NC}"
        ((errors++))
    else
        echo -e "${GREEN}✅ pnpm: $(pnpm --version)${NC}"
    fi
    
    return $errors
}

# Test 2: Check project structure
test_project_structure() {
    echo -e "${YELLOW}🏗️  Test 2: Checking project structure...${NC}"
    
    local errors=0
    
    # Check essential files
    local files=(
        "package.json"
        "app.json"
        "eas.json"
        "scripts/build-ios-local.sh"
        "scripts/quick-rebuild.sh"
        "scripts/ExportOptions.plist"
    )
    
    for file in "${files[@]}"; do
        if [ -f "$file" ]; then
            echo -e "${GREEN}✅ $file exists${NC}"
        else
            echo -e "${RED}❌ $file missing${NC}"
            ((errors++))
        fi
    done
    
    return $errors
}

# Test 3: Check device connectivity
test_device_connectivity() {
    echo -e "${YELLOW}📱 Test 3: Checking device connectivity...${NC}"
    
    if xcrun devicectl list devices | grep -q "iPhone"; then
        echo -e "${GREEN}✅ iOS device connected${NC}"
        return 0
    else
        echo -e "${YELLOW}⚠️  No iOS device connected (optional)${NC}"
        return 0
    fi
}

# Run all tests
run_all_tests() {
    echo -e "${BLUE}======================================${NC}"
    echo -e "${BLUE}   Local iOS Development Test Suite   ${NC}"
    echo -e "${BLUE}======================================${NC}"
    
    local total_errors=0
    
    test_prerequisites
    ((total_errors += $?))
    
    echo ""
    test_project_structure
    ((total_errors += $?))
    
    echo ""
    test_device_connectivity
    ((total_errors += $?))
    
    echo ""
    echo -e "${BLUE}======================================${NC}"
    
    if [ $total_errors -eq 0 ]; then
        echo -e "${GREEN}🎉 All tests passed! Your environment is ready.${NC}"
        echo -e "${BLUE}🚀 Next steps:${NC}"
        echo -e "${BLUE}   1. Connect your iPhone${NC}"
        echo -e "${BLUE}   2. Run: pnpm ios:build${NC}"
        echo -e "${BLUE}   3. For iteration: pnpm ios:quick${NC}"
    else
        echo -e "${YELLOW}⚠️  $total_errors issues found.${NC}"
        echo -e "${BLUE}💡 Run 'pnpm ios:setup' for automated setup${NC}"
    fi
    
    return $total_errors
}

# Main execution
run_all_tests 