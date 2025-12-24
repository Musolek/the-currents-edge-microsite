# Step-by-Step: Creating Your Xcode Project

Follow these instructions exactly. Each step includes what to click and what to expect.

## Prerequisites Check

Before starting, make sure you have:
- ✅ macOS installed
- ✅ Xcode 15.0 or later installed (check: Xcode → About Xcode)
- ✅ The `SautiSoul/` folder with all the source files

---

## Step 1: Open Xcode

1. **Open Xcode** from Applications or Spotlight (Cmd+Space, type "Xcode")
2. If you see a welcome screen, click **"Create a new Xcode project"**
   - OR go to **File → New → Project** (or press `Cmd+Shift+N`)

---

## Step 2: Choose Project Template

You'll see a template selection screen:

1. **At the top**, make sure **"iOS"** tab is selected (should be by default)
2. **In the main area**, click on **"App"** (the icon with a phone and a square)
3. Click the blue **"Next"** button at the bottom right

---

## Step 3: Configure Your Project

You'll see a form with several fields. Fill it out like this:

### Product Name
- **Type:** `SautiSoul`
- (This is the name of your app)

### Team
- **Click the dropdown** and select your Apple Developer account
- If you don't have one, select "None" for now (you can add it later)
- If you see "Add an account...", you can skip it for now

### Organization Identifier
- **Type:** `com.yourname` (replace "yourname" with your name or company)
- Examples: `com.johnsmith` or `com.mycompany`
- This creates a unique identifier like: `com.yourname.SautiSoul`

### Bundle Identifier
- This will **auto-fill** based on Product Name + Organization Identifier
- Don't change it - it should show something like: `com.yourname.SautiSoul`

### Interface
- **Select:** `SwiftUI` (should be the default)
- (This is the UI framework we're using)

### Language
- **Select:** `Swift` (should be the default)

### Storage
- **✅ CHECK the box** that says **"Use SwiftData"**
- This is important! It enables data persistence.

### Include Tests
- You can check or uncheck this - it's optional
- If checked, Xcode will create a test target

### Click **"Next"** button (bottom right)

---

## Step 4: Choose Save Location

1. **Navigate to your project folder:**
   - In the file browser, go to where your `SautiSoul/` folder is located
   - **Important:** You want to save the Xcode project in the **SAME directory** as the `SautiSoul/` folder
   - **NOT inside** the `SautiSoul/` folder itself

   Example structure:
   ```
   /Users/yourname/
   ├── SautiSoul/          ← Your source code folder (already exists)
   └── SautiSoul.xcodeproj ← Xcode project (you're creating this)
   ```

2. **At the bottom**, you'll see "Create Git repository"
   - You can leave this checked or unchecked (your choice)

3. **Click "Create"** button (bottom right)

---

## Step 5: Xcode Opens Your Project

After clicking Create, Xcode will:
- Open your new project
- Show you the project navigator on the left
- Display `ContentView.swift` in the editor (we'll replace this)

**What you should see:**
- Left sidebar: Project navigator with "SautiSoul" at the top
- Center: Code editor with `ContentView.swift`
- Right sidebar: Inspector (can be hidden)

---

## Step 6: Delete Default Files

We need to remove Xcode's default files since we have our own:

1. **In the left sidebar (Project Navigator)**, find:
   - `ContentView.swift`
   - `SautiSoulApp.swift` (might be there)

2. **For each file:**
   - Right-click on the file
   - Select **"Delete"**
   - When asked "Move to Trash" or "Remove Reference":
     - Choose **"Move to Trash"** (we don't need these files)

---

## Step 7: Add Your Source Files

Now we'll add all the source code from the `SautiSoul/` folder:

1. **In the left sidebar**, right-click on the **"SautiSoul"** folder (the blue icon at the top)

2. **Select:** **"Add Files to 'SautiSoul'..."**

3. **Navigate to the `SautiSoul/` folder:**
   - In the file browser, find and open the `SautiSoul/` folder
   - You should see folders like: `App/`, `Models/`, `Services/`, etc.

4. **Select ALL files and folders:**
   - Click on `App` folder
   - Hold `Cmd` key and click on:
     - `Models`
     - `Services`
     - `Views`
     - `Components`
     - `Utils`
     - `Resources`
     - `SautiSoulApp.swift`
     - `Info.plist`
   - (Select everything EXCEPT any `.md` files or scripts)

5. **Important - Check these options at the bottom:**
   - ✅ **"Copy items if needed"** - CHECKED
   - ✅ **"Create groups"** - SELECTED (not "Create folder references")
   - ✅ **"Add to targets: SautiSoul"** - CHECKED

6. **Click "Add"** button (bottom right)

---

## Step 8: Verify Files Are Added

Check the left sidebar. You should now see:

```
SautiSoul
├── SautiSoul
│   ├── App
│   ├── Models
│   ├── Services
│   ├── Views
│   ├── Components
│   ├── Utils
│   ├── Resources
│   ├── SautiSoulApp.swift
│   └── Info.plist
└── Products
```

If you see this structure, you're good! ✅

---

## Step 9: Configure Project Settings

### 9a. Select the Project

1. **In the left sidebar**, click on the **blue "SautiSoul" icon** at the very top
   - This is the project file, not the folder

2. **In the center area**, you'll see project settings
   - Make sure **"SautiSoul"** is selected under **TARGETS** (not PROJECTS)

### 9b. General Tab

1. **Click the "General" tab** at the top (if not already selected)

2. **Deployment Info section:**
   - **iOS:** Change to `17.0` (click the dropdown)
   - **Devices:** Select `iPhone` (or `Universal` if you want iPad too)

3. **Scroll down to "Frameworks, Libraries, and Embedded Content"**

4. **Click the "+" button** below this section

5. **Add frameworks one by one:**
   - In the search box, type: `MusicKit`
   - Select `MusicKit.framework`
   - Click "Add"
   - Repeat for:
     - `NaturalLanguage.framework`
     - `CoreML.framework`

6. **For each framework you added:**
   - Make sure "Embed" is set to **"Do Not Embed"**

### 9c. Signing & Capabilities Tab

1. **Click "Signing & Capabilities" tab** at the top

2. **Signing section:**
   - ✅ **Check "Automatically manage signing"**
   - **Team:** Select your Apple Developer account (or "None" for now)

3. **Capabilities section:**
   - **Click the "+ Capability" button** (top left of the capabilities area)
   - **Add "MusicKit"** (search for it, then double-click)
   - (Optional) **Add "HealthKit"** if you want future health features

### 9d. Info Tab

1. **Click "Info" tab** at the top

2. **Verify these keys exist** (they should be from Info.plist):
   - `NSAppleMusicUsageDescription`
   - `NSHealthShareUsageDescription`
   - `LSApplicationQueriesSchemes`

   If they're missing, you can add them manually or they'll be read from Info.plist

### 9e. Build Settings (Optional Check)

1. **Click "Build Settings" tab**

2. **Search for "Swift Language Version"**
   - Should be set to "Swift 5.9" or latest

3. **Search for "iOS Deployment Target"**
   - Should be set to "17.0"

---

## Step 10: Build the Project

Let's make sure everything compiles:

1. **At the top of Xcode**, you'll see a device selector
   - Click it and select: **"iPhone 15"** (or any iOS 17+ simulator)

2. **Build the project:**
   - Press `Cmd+B` (or Product → Build)
   - Watch the bottom status bar for progress

3. **Check for errors:**
   - If you see **red errors** in the Issue Navigator (left sidebar, exclamation mark icon):
     - Click on each error to see what's wrong
     - Common issues:
       - Missing files: Make sure all files are added to target
       - Import errors: Check frameworks are added

4. **If build succeeds:**
   - You'll see "Build Succeeded" in the status bar
   - ✅ You're ready to run!

---

## Step 11: Run the App

1. **Make sure a simulator is selected** (iPhone 15 or similar)

2. **Run the app:**
   - Press `Cmd+R` (or click the Play ▶️ button at the top)
   - Wait for the simulator to launch

3. **What you should see:**
   - Simulator opens
   - App launches
   - **Onboarding screen** appears with "Welcome to Sauti Soul"
   - You can swipe through the onboarding steps

4. **If the app crashes or doesn't launch:**
   - Check the console at the bottom for error messages
   - Make sure all files are added to the target
   - Verify SwiftData is enabled

---

## Step 12: Test Navigation

Try navigating through the app:

1. **Onboarding:**
   - Click "Continue" through the 3 screens
   - Click "Let's Start" on the last screen

2. **Home Screen:**
   - You should see 6 mood cards in a grid
   - Try clicking on one (e.g., "Radiant")

3. **Loading Screen:**
   - After selecting a mood, you'll see a loading screen
   - Then it should go to the player (or show an error if music service isn't configured)

---

## Troubleshooting Common Issues

### "Cannot find type 'Mood' in scope"
**Fix:**
1. Click on `Models/Mood.swift` in the navigator
2. In the right sidebar (File Inspector), check "Target Membership"
3. Make sure "SautiSoul" is checked

### "No such module 'MusicKit'"
**Fix:**
1. Go to General tab → Frameworks
2. Make sure MusicKit.framework is added
3. Make sure it's set to "Do Not Embed"

### Build errors about missing files
**Fix:**
1. Right-click on the file in navigator
2. Select "Show File Inspector" (right sidebar)
3. Check "Target Membership" → ensure "SautiSoul" is checked

### App crashes on launch
**Fix:**
1. Check the console for error messages
2. Verify `SautiSoulApp.swift` is the main entry point
3. Make sure SwiftData models are properly configured

### Simulator doesn't launch
**Fix:**
1. Xcode → Settings → Platforms
2. Download iOS 17.0 Simulator if missing
3. Try a different simulator (iPhone 14, iPhone 15, etc.)

---

## Success Checklist

You're done when:
- ✅ Project builds without errors (`Cmd+B` succeeds)
- ✅ App runs on simulator (`Cmd+R` launches app)
- ✅ Onboarding screen appears
- ✅ Can navigate to home screen
- ✅ Can select a mood

---

## Next Steps After Setup

Once everything works:

1. **Add App Icon:**
   - Open `Assets.xcassets` → `AppIcon`
   - Add your 1024x1024 icon image

2. **Test Music Integration:**
   - The app uses `MockMusicService` by default
   - To use real Apple Music, implement MusicKit search

3. **Add ML Models:**
   - Train CoreML models (see original spec)
   - Add to `Resources/MLModels/`

4. **Customize:**
   - Update colors, fonts, etc.
   - Add your branding

---

## Need Help?

If you're stuck:
1. Check the error messages in Xcode (red text)
2. Verify all steps were followed exactly
3. Make sure you're using Xcode 15.0+
4. Ensure iOS 17.0 SDK is installed

**You're all set! 🎉**

The app should now be running. Enjoy building Sauti Soul!

