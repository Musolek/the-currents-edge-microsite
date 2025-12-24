#!/bin/bash
# Build script for Sauti Soul
# Usage: ./build.sh [clean|build|test]

ACTION=${1:-build}

case $ACTION in
    clean)
        echo "Cleaning build artifacts..."
        if [ -f "SautiSoul.xcodeproj/project.pbxproj" ]; then
            xcodebuild clean -project SautiSoul.xcodeproj -scheme SautiSoul
        else
            echo "⚠️  Xcode project not found. Please create it first."
        fi
        ;;
    build)
        echo "Building Sauti Soul..."
        if [ -f "SautiSoul.xcodeproj/project.pbxproj" ]; then
            xcodebuild build -project SautiSoul.xcodeproj -scheme SautiSoul \
                -destination 'platform=iOS Simulator,name=iPhone 15'
        else
            echo "⚠️  Xcode project not found. Please create it first (see create_xcode_project.md)"
        fi
        ;;
    test)
        echo "Running tests..."
        if [ -f "SautiSoul.xcodeproj/project.pbxproj" ]; then
            xcodebuild test -project SautiSoul.xcodeproj -scheme SautiSoul \
                -destination 'platform=iOS Simulator,name=iPhone 15'
        else
            echo "⚠️  Xcode project not found. Please create it first (see create_xcode_project.md)"
        fi
        ;;
    *)
        echo "Usage: $0 [clean|build|test]"
        exit 1
        ;;
esac

