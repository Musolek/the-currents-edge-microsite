// MARK: - Home View
// Views/Home/HomeView.swift

import SwiftUI

struct HomeView: View {
    @Bindable var appState: AppState
    @Bindable var settings: AppSettings
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "#1a1a2e"), Color(hex: "#0f0f1e")],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 60) {
                // Header
                HStack {
                    Text("SAUTI SOUL")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                        .letterSpacing(3)
                    
                    Spacer()
                    
                    HStack(spacing: 16) {
                        if settings.moodThreadUnlocked {
                            Button(action: {
                                appState.currentScreen = .thread
                            }) {
                                Image(systemName: "chart.line.uptrend.xyaxis")
                                    .foregroundColor(.white.opacity(0.7))
                                    .frame(width: 44, height: 44)
                                    .background(Color.white.opacity(0.1))
                                    .clipShape(Circle())
                            }
                        }
                        
                        Button(action: {
                            appState.currentScreen = .settings
                        }) {
                            Image(systemName: "gearshape")
                                .foregroundColor(.white.opacity(0.7))
                                .frame(width: 44, height: 44)
                                .background(Color.white.opacity(0.1))
                                .clipShape(Circle())
                        }
                    }
                }
                .padding(.horizontal, 30)
                .padding(.top, 60)
                
                // Title
                Text("How's your inner weather?")
                    .font(.system(size: 22, weight: .light))
                    .foregroundColor(.white.opacity(0.9))
                
                // Mood Grid
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 24) {
                    ForEach(Array(Mood.all.enumerated()), id: \.element.id) { index, mood in
                        MoodCard(mood: mood) {
                            appState.selectedMood = mood
                            if settings.enableContextTags && settings.contextTagsUnlocked {
                                appState.currentScreen = .context
                            } else {
                                generatePlaylist(mood: mood, context: nil)
                            }
                        }
                        .animation(.easeInOut(duration: 0.6).delay(Double(index) * 0.1), value: index)
                    }
                }
                .padding(.horizontal, 20)
                
                // Journal button (if unlocked)
                if settings.journalingUnlocked {
                    Button(action: {
                        appState.currentScreen = .journal
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: "book")
                            Text("Reflect")
                        }
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(20)
                    }
                }
                
                Spacer()
            }
        }
    }
    
    private func generatePlaylist(mood: Mood, context: Context?) {
        appState.currentScreen = .loading
        appState.skipCount = 0
        
        Task {
            do {
                let musicService = MusicServiceFactory.create(serviceType: settings.preferredMusicService)
                let tracks = try await musicService.search(mood: mood, context: context)
                
                // Use ML service to recommend tracks
                let recommendedTracks = MLService.shared.recommendTracks(
                    mood: mood,
                    context: context,
                    availableTracks: tracks,
                    userFeedback: [],
                    journalText: nil
                )
                
                await MainActor.run {
                    appState.currentPlaylist = recommendedTracks
                    appState.currentTrackIndex = 0
                    appState.progress = 0
                    appState.currentScreen = .player
                    appState.isPlaying = true
                    settings.incrementSessionCount()
                }
            } catch {
                await MainActor.run {
                    appState.currentScreen = .home
                }
            }
        }
    }
}

