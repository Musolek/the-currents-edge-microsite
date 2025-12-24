# Sauti Soul - iOS App

A mood-based music recommendation app built with SwiftUI and SwiftData.

## Features

- **Mood-Based Recommendations**: Select from 6 emotional states (Radiant, Steady, Pensive, Heavy, Restless, Hollow)
- **Context Tags**: Add activity context to refine recommendations (Moving, Resting, Working, Processing, Social)
- **On-Device ML**: Uses NaturalLanguage framework and CoreML for sentiment analysis and recommendations
- **Privacy-First**: All mood data and journal entries stay on your device
- **Progressive Unlocks**: Features unlock as you use the app (Context tags at 3 sessions, Journaling at 5, etc.)
- **Music Service Integration**: Supports Apple Music and Spotify (Spotify implementation pending)

## Project Structure

```
SautiSoul/
├── SautiSoulApp.swift          # App entry point
├── App/
│   ├── AppState.swift          # Global app state
│   └── RootView.swift           # Root navigation
├── Models/
│   ├── Mood.swift              # Mood model with valence/arousal
│   ├── Track.swift             # Track and AudioFeatures
│   ├── Context.swift           # Context tags
│   ├── MoodHistory.swift       # MoodEntry (SwiftData)
│   ├── TrackFeedback.swift     # User feedback (SwiftData)
│   ├── Mixtape.swift           # Saved playlists (SwiftData)
│   └── AppSettings.swift       # User preferences
├── Services/
│   ├── MusicService.swift      # Protocol
│   ├── AppleMusicService.swift # Apple Music integration
│   ├── SpotifyService.swift    # Spotify integration (stub)
│   ├── MockMusicService.swift  # For development
│   ├── MusicServiceFactory.swift
│   └── MLService.swift         # ML recommendations
├── Views/
│   ├── Onboarding/
│   ├── Home/
│   ├── Context/
│   ├── Player/
│   ├── Journal/
│   ├── Thread/
│   ├── Settings/
│   ├── LoadingView.swift
│   └── SilenceView.swift
├── Components/
│   ├── MoodCard.swift
│   ├── ContextTagButton.swift
│   └── GradientBackground.swift
└── Utils/
    ├── Color+Hex.swift
    ├── UserDefaults+Helpers.swift
    └── DesignSystem.swift
```

## Setup

1. Open in Xcode 15.0+
2. Set your development team in project settings
3. Add MusicKit capability for Apple Music integration
4. Run on iOS 17.0+ device or simulator

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+

## Next Steps

- [ ] Complete Spotify service implementation
- [ ] Add CoreML models (see ML Training Guide)
- [ ] Implement encryption for journal entries
- [ ] Add HealthKit integration
- [ ] Implement mixtape creation and management
- [ ] Add haptic feedback
- [ ] Implement federated learning (future)

## License

Built with care. For you, not metrics.

