# Sauti Soul - Quick Start

## What is Sauti Soul?

Sauti Soul is a mood-based music recommendation app that:
- Recommends music based on your emotional state (6 moods: Radiant, Steady, Pensive, Heavy, Restless, Hollow)
- Uses on-device machine learning for privacy
- Unlocks features as you use it (progressive disclosure)
- Keeps all your data on your device

## Getting Started

1. **Create Xcode Project** (see `PROJECT_SETUP.md` for detailed instructions)
   - New iOS App project
   - SwiftUI + SwiftData
   - iOS 17.0+ target

2. **Add All Files**
   - Copy all files from `SautiSoul/` directory into your Xcode project
   - Ensure all files are added to the target

3. **Configure Capabilities**
   - Add MusicKit capability (for Apple Music)
   - Add HealthKit capability (optional, for future)

4. **Run the App**
   - Build and run on iOS 17.0+ simulator or device
   - You'll see the onboarding flow first

## Key Features

### Mood Selection
- 6 emotional states with unique gradients and icons
- Each mood has valence (-1 to 1) and arousal (-1 to 1) coordinates

### Context Tags (Unlocks at 3 sessions)
- Moving, Resting, Working, Processing, Social
- Adjusts recommendations based on activity

### Journaling (Unlocks at 5 sessions)
- Optional text entry for mood
- Uses NLP to refine emotional coordinates
- All data encrypted and stored on-device

### Mood Thread (Unlocks at 7 sessions)
- Visual timeline of your mood history
- See patterns over time

### Mixtapes (Unlocks at 14 sessions)
- Save playlists from liked tracks
- Add notes and reminders

## Architecture

- **SwiftUI**: Modern declarative UI
- **SwiftData**: On-device persistence
- **NaturalLanguage**: Sentiment analysis
- **CoreML**: Machine learning (models to be added)
- **MusicKit**: Apple Music integration
- **Observable**: State management (iOS 17+)

## Development Notes

- Uses `MockMusicService` by default for development
- Switch to `AppleMusicService` or `SpotifyService` for real music
- ML models need to be trained (see original spec for ML training guide)
- Journal encryption not yet implemented (TODO)

## Testing

The app works with mock data out of the box. To test with real music:
1. Configure MusicKit in project settings
2. Update `MusicServiceFactory` to use `AppleMusicService`
3. Request MusicKit authorization in app

## Next Steps

1. Complete Apple Music integration
2. Train and add CoreML models
3. Implement journal encryption
4. Add Spotify OAuth flow
5. Implement mixtape persistence
6. Add unit tests

