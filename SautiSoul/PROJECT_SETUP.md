# Sauti Soul - Xcode Project Setup Guide

## Creating the Xcode Project

1. **Open Xcode** and create a new project:
   - Choose "iOS" → "App"
   - Product Name: `SautiSoul`
   - Interface: `SwiftUI`
   - Language: `Swift`
   - Use SwiftData: ✅ (checked)
   - Minimum Deployment: iOS 17.0

2. **Add Files to Project**:
   - Drag all files from the `SautiSoul/` directory into your Xcode project
   - Make sure "Copy items if needed" is checked
   - Add to target: `SautiSoul`

3. **Configure Capabilities**:
   - Select your project target
   - Go to "Signing & Capabilities"
   - Click "+ Capability"
   - Add:
     - **MusicKit** (for Apple Music integration)
     - **HealthKit** (optional, for future integration)

4. **Update Info.plist**:
   - The `Info.plist` file is already configured with required usage descriptions
   - Or add these keys in Xcode's Info tab:
     - `NSAppleMusicUsageDescription`: "Sauti Soul needs access to play music based on your mood."
     - `NSHealthShareUsageDescription`: "Sauti Soul can read your logged moods to personalize recommendations. This data never leaves your device."
     - `LSApplicationQueriesSchemes`: Add `spotify`

5. **Add Frameworks**:
   - Select your project target
   - Go to "General" → "Frameworks, Libraries, and Embedded Content"
   - Add:
     - `MusicKit.framework` (for Apple Music)
     - `NaturalLanguage.framework` (for sentiment analysis)
     - `CoreML.framework` (for ML models)

6. **Update AppleMusicService.swift**:
   - Uncomment the `import MusicKit` line
   - Implement the MusicKit search functionality (see code comments)

## Project Structure in Xcode

Your Xcode project should have this structure:

```
SautiSoul/
├── SautiSoulApp.swift
├── App/
│   ├── AppState.swift
│   └── RootView.swift
├── Models/
│   ├── Mood.swift
│   ├── Track.swift
│   ├── Context.swift
│   ├── MoodHistory.swift
│   ├── TrackFeedback.swift
│   ├── Mixtape.swift
│   └── AppSettings.swift
├── Services/
│   ├── MusicService.swift
│   ├── AppleMusicService.swift
│   ├── SpotifyService.swift
│   ├── MockMusicService.swift
│   ├── MusicServiceFactory.swift
│   └── MLService.swift
├── Views/
│   ├── Onboarding/
│   │   └── OnboardingView.swift
│   ├── Home/
│   │   └── HomeView.swift
│   ├── Context/
│   │   └── ContextSelectionView.swift
│   ├── Player/
│   │   └── PlayerView.swift
│   ├── Journal/
│   │   └── JournalView.swift
│   ├── Thread/
│   │   └── MoodThreadView.swift
│   ├── Settings/
│   │   └── SettingsView.swift
│   ├── Mixtape/
│   │   └── MixtapeView.swift
│   ├── LoadingView.swift
│   └── SilenceView.swift
├── Components/
│   ├── MoodCard.swift
│   ├── ContextTagButton.swift
│   └── GradientBackground.swift
├── Utils/
│   ├── Color+Hex.swift
│   ├── UserDefaults+Helpers.swift
│   └── DesignSystem.swift
└── Resources/
    ├── Assets.xcassets
    └── Info.plist
```

## Testing

1. **Run on Simulator**: The app should launch and show the onboarding screen
2. **Test with Mock Service**: The app uses `MockMusicService` by default for development
3. **Test Music Integration**: Switch to `AppleMusicService` once MusicKit is configured

## Next Steps

- [ ] Complete Apple Music integration
- [ ] Add CoreML models (see ML Training Guide in original spec)
- [ ] Implement Spotify OAuth flow
- [ ] Add encryption for journal entries
- [ ] Implement mixtape persistence
- [ ] Add unit tests

## Troubleshooting

**Issue**: "Cannot find 'MusicKit' in scope"
- **Solution**: Make sure MusicKit framework is added to your project and the import is uncommented

**Issue**: SwiftData models not persisting
- **Solution**: Ensure SwiftData is enabled in project settings and model container is properly configured

**Issue**: Colors not displaying correctly
- **Solution**: Verify `Color+Hex.swift` extension is included in your target

