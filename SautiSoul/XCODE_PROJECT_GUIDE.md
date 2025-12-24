# Complete Xcode Project Setup Guide

This guide will walk you through creating the Xcode project from scratch.

## Prerequisites

- macOS with Xcode 15.0 or later installed
- iOS 17.0+ SDK
- Apple Developer account (for device testing)

## Step 1: Create the Xcode Project

1. **Open Xcode**
2. **File → New → Project** (or `Cmd+Shift+N`)
3. **Select Template:**
   - Choose "iOS" tab
   - Select "App"
   - Click "Next"

4. **Configure Project:**
   - **Product Name:** `SautiSoul`
   - **Team:** Select your development team
   - **Organization Identifier:** e.g., `com.yourname` or `com.yourcompany`
   - **Bundle Identifier:** Will auto-generate (e.g., `com.yourname.SautiSoul`)
   - **Interface:** `SwiftUI`
   - **Language:** `Swift`
   - **✅ Storage:** Check "Use SwiftData"
   - **✅ Include Tests:** Check if you want unit tests
   - Click "Next"

5. **Choose Location:**
   - Navigate to the **parent directory** of `SautiSoul/`
   - **Important:** Save the project in the same directory where `SautiSoul/` folder exists
   - Click "Create"

## Step 2: Add Source Files to Project

1. **Delete Default Files:**
   - In Xcode, delete the auto-generated `ContentView.swift` (if it exists)
   - Keep `SautiSoulApp.swift` for now (we'll replace it)

2. **Add All Source Files:**
   - In Xcode, right-click on the project name in the navigator
   - Select "Add Files to SautiSoul..."
   - Navigate to the `SautiSoul/` directory
   - Select ALL files and folders:
     - `App/`
     - `Models/`
     - `Services/`
     - `Views/`
     - `Components/`
     - `Utils/`
     - `Resources/`
     - `SautiSoulApp.swift`
     - `Info.plist`
   - **Important Options:**
     - ✅ Check "Copy items if needed"
     - ✅ Check "Create groups" (not folder references)
     - ✅ Select "SautiSoul" target
   - Click "Add"

3. **Replace SautiSoulApp.swift:**
   - Delete the auto-generated `SautiSoulApp.swift`
   - The one from `SautiSoul/` should now be in the project

## Step 3: Configure Project Settings

1. **Select Project Target:**
   - Click on "SautiSoul" project in navigator
   - Select "SautiSoul" target (under TARGETS)

2. **General Tab:**
   - **Deployment Info:**
     - iOS: `17.0` (minimum)
     - Devices: `iPhone` (or `Universal` if you want iPad support)
   - **Frameworks, Libraries, and Embedded Content:**
     - Click "+" button
     - Add:
       - `MusicKit.framework`
       - `NaturalLanguage.framework`
       - `CoreML.framework`
     - Set all to "Do Not Embed"

3. **Signing & Capabilities Tab:**
   - **Signing:**
     - ✅ Check "Automatically manage signing"
     - Select your Team
   - **Capabilities:**
     - Click "+ Capability"
     - Add "MusicKit"
     - (Optional) Add "HealthKit" for future features

4. **Info Tab:**
   - Verify these keys exist (they should be from Info.plist):
     - `NSAppleMusicUsageDescription`
     - `NSHealthShareUsageDescription`
     - `LSApplicationQueriesSchemes` (with `spotify` entry)

5. **Build Settings:**
   - Search for "Swift Language Version"
   - Set to "Swift 5.9" or latest
   - Search for "iOS Deployment Target"
   - Set to "17.0"

## Step 4: Configure Assets

1. **App Icon:**
   - Select `Assets.xcassets` in navigator
   - Click on "AppIcon"
   - Add your app icon images (1024x1024 for iOS)

2. **Verify Assets Structure:**
   - `Assets.xcassets` should exist
   - `AppIcon.appiconset` should be present

## Step 5: Update Info.plist

The `Info.plist` is already configured, but verify in Xcode:

1. Select `Info.plist` in navigator
2. Verify these entries:
   ```xml
   <key>NSAppleMusicUsageDescription</key>
   <string>Sauti Soul needs access to play music based on your mood.</string>
   
   <key>NSHealthShareUsageDescription</key>
   <string>Sauti Soul can read your logged moods to personalize recommendations. This data never leaves your device.</string>
   
   <key>LSApplicationQueriesSchemes</key>
   <array>
       <string>spotify</string>
   </array>
   ```

## Step 6: Fix Any Import Issues

1. **AppleMusicService.swift:**
   - Currently has MusicKit import commented out
   - Once project is set up, uncomment: `import MusicKit`
   - Implement the MusicKit search functionality

2. **Build the Project:**
   - `Cmd+B` to build
   - Fix any import or syntax errors

## Step 7: Configure Scheme

1. **Product → Scheme → Edit Scheme**
2. **Run:**
   - Build Configuration: `Debug`
   - Executable: `SautiSoul.app`
3. **Test:**
   - Build Configuration: `Debug`
4. **Archive:**
   - Build Configuration: `Release`

## Step 8: Test the App

1. **Select Simulator:**
   - Choose iPhone 15 (or any iOS 17+ simulator)
   - Product → Destination → iOS Simulator

2. **Run:**
   - `Cmd+R` or click the Play button
   - App should launch and show onboarding screen

## Troubleshooting

### "Cannot find type 'Mood' in scope"
- Make sure all files in `Models/` are added to the target
- Check that files are in "SautiSoul" group, not just folder reference

### "No such module 'MusicKit'"
- Add MusicKit framework in General → Frameworks
- Make sure MusicKit capability is added

### "SwiftData model not found"
- Verify SwiftData is enabled in project creation
- Check that `@Model` classes are properly imported

### Build errors about missing files
- Verify all files are added to the target
- Check "Copy items if needed" was selected

## Next Steps

After setup is complete:
1. Test the app runs on simulator
2. Implement MusicKit integration
3. Add CoreML models (see ML Training Guide)
4. Customize app icon and assets
5. Configure app store metadata

## Project Structure in Xcode

Your Xcode project navigator should look like:

```
SautiSoul
├── SautiSoul
│   ├── App
│   │   ├── AppState.swift
│   │   └── RootView.swift
│   ├── Models
│   │   ├── Mood.swift
│   │   ├── Track.swift
│   │   └── ...
│   ├── Services
│   │   ├── MusicService.swift
│   │   └── ...
│   ├── Views
│   │   ├── Onboarding
│   │   ├── Home
│   │   └── ...
│   ├── Components
│   ├── Utils
│   ├── Resources
│   │   ├── Assets.xcassets
│   │   └── Info.plist
│   └── SautiSoulApp.swift
└── Products
    └── SautiSoul.app
```

## Verification Checklist

- [ ] Project builds without errors (`Cmd+B`)
- [ ] App runs on simulator
- [ ] Onboarding screen appears
- [ ] All source files are in project
- [ ] MusicKit framework added
- [ ] Capabilities configured
- [ ] Info.plist has required keys
- [ ] Assets.xcassets exists
- [ ] SwiftData models compile

Once all items are checked, you're ready to develop! 🎉

