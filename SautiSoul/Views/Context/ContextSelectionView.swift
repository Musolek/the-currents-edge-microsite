// MARK: - Context Selection View
// Views/Context/ContextSelectionView.swift

import SwiftUI

struct ContextSelectionView: View {
    @Bindable var appState: AppState
    @Bindable var settings: AppSettings
    
    var body: some View {
        ZStack {
            if let mood = appState.selectedMood {
                mood.gradient
                    .ignoresSafeArea()
            }
            
            VStack(spacing: 40) {
                // Back button
                HStack {
                    Button(action: {
                        appState.currentScreen = .home
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(Color.white.opacity(0.2))
                            .clipShape(Circle())
                    }
                    .padding(.leading, 40)
                    .padding(.top, 40)
                    
                    Spacer()
                }
                
                Spacer()
                
                Text("What are you doing?")
                    .font(.system(size: 24, weight: .light))
                    .foregroundColor(.white)
                    .padding(.bottom, 40)
                
                VStack(spacing: 16) {
                    ForEach(Context.all) { context in
                        ContextTagButton(context: context) {
                            appState.selectedContext = context
                            generatePlaylist()
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                Button(action: {
                    generatePlaylist()
                }) {
                    Text("Skip this")
                        .font(.system(size: 16))
                        .foregroundColor(.white.opacity(0.7))
                        .underline()
                }
                
                Spacer()
            }
        }
    }
    
    private func generatePlaylist() {
        guard let mood = appState.selectedMood else { return }
        appState.currentScreen = .loading
        appState.skipCount = 0
        
        Task {
            do {
                let musicService = MusicServiceFactory.create(serviceType: settings.preferredMusicService)
                let tracks = try await musicService.search(mood: mood, context: appState.selectedContext)
                
                let recommendedTracks = MLService.shared.recommendTracks(
                    mood: mood,
                    context: appState.selectedContext,
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

