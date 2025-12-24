# Quick Reference - Xcode Project Setup

## The 5-Minute Version

1. **Open Xcode** → File → New → Project
2. **Choose:** iOS → App → Next
3. **Fill in:**
   - Product Name: `SautiSoul`
   - Organization ID: `com.yourname`
   - Interface: `SwiftUI`
   - ✅ Use SwiftData
   - iOS: `17.0`
4. **Save** in same folder as `SautiSoul/` (not inside it)
5. **Delete** default `ContentView.swift`
6. **Add files:** Right-click project → Add Files → Select all from `SautiSoul/` folder
7. **Settings:**
   - General → iOS 17.0
   - Frameworks → Add MusicKit, NaturalLanguage, CoreML
   - Capabilities → Add MusicKit
8. **Build:** Cmd+B
9. **Run:** Cmd+R

## Detailed Steps

👉 **For complete step-by-step instructions with screenshots guidance, see:**
**[STEP_BY_STEP_SETUP.md](STEP_BY_STEP_SETUP.md)**

## Common Settings

| Setting | Value |
|---------|-------|
| Product Name | `SautiSoul` |
| Interface | `SwiftUI` |
| Language | `Swift` |
| Storage | ✅ Use SwiftData |
| iOS Deployment | `17.0` |
| Frameworks | MusicKit, NaturalLanguage, CoreML |
| Capabilities | MusicKit (required), HealthKit (optional) |

## File Structure in Xcode

After adding files, you should see:
```
SautiSoul (project)
└── SautiSoul (target)
    ├── App/
    ├── Models/
    ├── Services/
    ├── Views/
    ├── Components/
    ├── Utils/
    ├── Resources/
    ├── SautiSoulApp.swift
    └── Info.plist
```

## Keyboard Shortcuts

- `Cmd+B` - Build
- `Cmd+R` - Run
- `Cmd+Shift+N` - New Project
- `Cmd+1` - Show Navigator
- `Cmd+0` - Hide/Show Left Sidebar

## Troubleshooting Quick Fixes

| Error | Quick Fix |
|-------|-----------|
| "Cannot find type 'Mood'" | Check file target membership |
| "No such module 'MusicKit'" | Add framework in General tab |
| Build fails | Check all files added to target |
| App crashes | Check console for error messages |

---

**For detailed help, see [STEP_BY_STEP_SETUP.md](STEP_BY_STEP_SETUP.md)**

