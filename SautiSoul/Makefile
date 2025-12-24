# Makefile for Sauti Soul iOS App
# Usage: make [target]

.PHONY: help setup clean build test lint format

# Default target
help:
	@echo "Sauti Soul iOS App - Makefile"
	@echo ""
	@echo "Available targets:"
	@echo "  make setup    - Run setup script"
	@echo "  make clean    - Clean build artifacts"
	@echo "  make build    - Build the project"
	@echo "  make test     - Run tests"
	@echo "  make lint     - Run SwiftLint (if installed)"
	@echo "  make format   - Format Swift code (if swiftformat installed)"
	@echo ""

setup:
	@chmod +x setup.sh
	@./setup.sh

clean:
	@echo "Cleaning build artifacts..."
	@if [ -d "build" ]; then rm -rf build; fi
	@if [ -d "DerivedData" ]; then rm -rf DerivedData; fi
	@echo "✓ Clean complete"

build:
	@echo "Building Sauti Soul..."
	@if [ -f "SautiSoul.xcodeproj/project.pbxproj" ]; then \
		xcodebuild build -project SautiSoul.xcodeproj -scheme SautiSoul \
			-destination 'platform=iOS Simulator,name=iPhone 15' \
			-quiet; \
	else \
		echo "⚠️  Xcode project not found. Please create it first (see create_xcode_project.md)"; \
	fi

test:
	@echo "Running tests..."
	@if [ -f "SautiSoul.xcodeproj/project.pbxproj" ]; then \
		xcodebuild test -project SautiSoul.xcodeproj -scheme SautiSoul \
			-destination 'platform=iOS Simulator,name=iPhone 15' \
			-quiet; \
	else \
		echo "⚠️  Xcode project not found. Please create it first (see create_xcode_project.md)"; \
	fi

lint:
	@if command -v swiftlint >/dev/null 2>&1; then \
		echo "Running SwiftLint..."; \
		swiftlint lint; \
	else \
		echo "⚠️  SwiftLint not installed. Install with: brew install swiftlint"; \
	fi

format:
	@if command -v swiftformat >/dev/null 2>&1; then \
		echo "Formatting Swift code..."; \
		swiftformat SautiSoul/; \
	else \
		echo "⚠️  swiftformat not installed. Install with: brew install swiftformat"; \
	fi

