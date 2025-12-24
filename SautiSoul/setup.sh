#!/bin/bash

# Sauti Soul iOS App Setup Script
# This script helps set up the Xcode project structure

set -e

echo "🎵 Sauti Soul iOS App Setup"
echo "=========================="
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if we're in the right directory
if [ ! -d "SautiSoul" ]; then
    echo -e "${YELLOW}Warning: SautiSoul directory not found.${NC}"
    echo "Please run this script from the project root directory."
    exit 1
fi

echo -e "${BLUE}Step 1: Creating Xcode project structure...${NC}"

# Create Resources directory if it doesn't exist
mkdir -p SautiSoul/Resources
mkdir -p SautiSoul/Resources/Assets.xcassets
mkdir -p SautiSoul/Resources/MLModels

echo -e "${GREEN}✓ Directory structure created${NC}"

echo ""
echo -e "${BLUE}Step 2: Creating Assets.xcassets structure...${NC}"

# Create AppIcon.appiconset
mkdir -p SautiSoul/Resources/Assets.xcassets/AppIcon.appiconset
cat > SautiSoul/Resources/Assets.xcassets/AppIcon.appiconset/Contents.json << 'EOF'
{
  "images" : [
    {
      "idiom" : "universal",
      "platform" : "ios",
      "size" : "1024x1024"
    }
  ],
  "info" : {
    "author" : "xcode",
    "version" : 1
  }
}
EOF

# Create Contents.json for Assets.xcassets
cat > SautiSoul/Resources/Assets.xcassets/Contents.json << 'EOF'
{
  "info" : {
    "author" : "xcode",
    "version" : 1
  }
}
EOF

echo -e "${GREEN}✓ Assets structure created${NC}"

echo ""
echo -e "${BLUE}Step 3: Creating Xcode project file template...${NC}"

cat > SautiSoul/create_xcode_project.md << 'EOF'
# Creating the Xcode Project

Since Xcode project files are complex binary/XML files, you need to create the project in Xcode:

## Steps:

1. Open Xcode
2. File → New → Project
3. Choose "iOS" → "App"
4. Fill in:
   - Product Name: `SautiSoul`
   - Team: (Your development team)
   - Organization Identifier: (e.g., `com.yourname`)
   - Interface: `SwiftUI`
   - Language: `Swift`
   - ✅ Use SwiftData
   - Minimum Deployment: `iOS 17.0`

5. Save the project in the parent directory (not inside SautiSoul/)

6. After creating the project:
   - Delete the default `ContentView.swift` and `SautiSoulApp.swift` (if auto-generated)
   - Drag all files from `SautiSoul/` into the Xcode project
   - Make sure "Copy items if needed" is checked
   - Add to target: `SautiSoul`

7. Configure Capabilities:
   - Select project target → Signing & Capabilities
   - Add "MusicKit" capability
   - Add "HealthKit" capability (optional)

8. Add Frameworks:
   - Select project target → General → Frameworks, Libraries, and Embedded Content
   - Add: MusicKit.framework, NaturalLanguage.framework, CoreML.framework

9. Update Info.plist:
   - The Info.plist is already configured, but verify in Xcode's Info tab

10. Build and run!
EOF

echo -e "${GREEN}✓ Setup instructions created${NC}"

echo ""
echo -e "${BLUE}Step 4: Creating build configuration...${NC}"

# Create a simple build script
cat > SautiSoul/build.sh << 'EOF'
#!/bin/bash
# Build script for Sauti Soul
# Usage: ./build.sh [clean|build|test]

ACTION=${1:-build}

case $ACTION in
    clean)
        echo "Cleaning build artifacts..."
        xcodebuild clean -project SautiSoul.xcodeproj -scheme SautiSoul
        ;;
    build)
        echo "Building Sauti Soul..."
        xcodebuild build -project SautiSoul.xcodeproj -scheme SautiSoul -destination 'platform=iOS Simulator,name=iPhone 15'
        ;;
    test)
        echo "Running tests..."
        xcodebuild test -project SautiSoul.xcodeproj -scheme SautiSoul -destination 'platform=iOS Simulator,name=iPhone 15'
        ;;
    *)
        echo "Usage: $0 [clean|build|test]"
        exit 1
        ;;
esac
EOF

chmod +x SautiSoul/build.sh

echo -e "${GREEN}✓ Build script created${NC}"

echo ""
echo -e "${BLUE}Step 5: Creating Xcode scheme template...${NC}"

cat > SautiSoul/xcode_scheme_setup.md << 'EOF'
# Xcode Scheme Configuration

After creating your Xcode project, configure the scheme:

1. Product → Scheme → Edit Scheme
2. Run → Info:
   - Build Configuration: Debug
   - Executable: SautiSoul.app
3. Run → Options:
   - Language: System Language
   - Region: System Region
4. Test → Info:
   - Build Configuration: Debug
5. Archive → Info:
   - Build Configuration: Release

## Recommended Build Settings:

- Swift Language Version: Swift 5.9
- iOS Deployment Target: 17.0
- Supported Platforms: iOS
- Code Signing: Automatic
EOF

echo -e "${GREEN}✓ Scheme setup guide created${NC}"

echo ""
echo -e "${YELLOW}⚠️  Important Next Steps:${NC}"
echo ""
echo "1. Create the Xcode project manually (see create_xcode_project.md)"
echo "2. Add all files from SautiSoul/ to your Xcode project"
echo "3. Configure capabilities (MusicKit, HealthKit)"
echo "4. Build and run!"
echo ""
echo -e "${GREEN}Setup complete! 🎉${NC}"
echo ""
echo "For detailed instructions, see:"
echo "  - PROJECT_SETUP.md"
echo "  - QUICKSTART.md"
echo "  - create_xcode_project.md"

