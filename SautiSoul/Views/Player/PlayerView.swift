// MARK: - Player View
// Views/Player/PlayerView.swift

import SwiftUI

struct PlayerView: View {
    @Bindable var appState: AppState
    @Bindable var settings: AppSettings
    @State private var showMenu = false
    
    var currentTrack: Track? {
        guard appState.currentTrackIndex < appState.currentPlaylist.count else { return nil }
        return appState.currentPlaylist[appState.currentTrackIndex]
    }
    
    var isLiked: Bool {
        guard let track = currentTrack else { return false }
        return appState.likedTracks.contains(track.id)
    }
    
    var body: some View {
        ZStack {
            if let mood = appState.selectedMood {
                mood.gradient
                    .ignoresSafeArea()
            }
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button(action: {
                        appState.currentScreen = .home
                        appState.isPlaying = false
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(Color.white.opacity(0.2))
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    if let mood = appState.selectedMood {
                        Text(mood.icon)
                            .font(.system(size: 32))
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        showMenu.toggle()
                    }) {
                        Image(systemName: "gearshape")
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(Color.white.opacity(0.2))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal, 30)
                .padding(.top, 40)
                
                // Context Menu
                if showMenu {
                    VStack(alignment: .leading, spacing: 8) {
                        if settings.journalingUnlocked {
                            Button(action: {
                                appState.currentScreen = .journal
                                showMenu = false
                            }) {
                                HStack {
                                    Image(systemName: "book")
                                    Text("Reflect on this")
                                }
                                .font(.system(size: 15))
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 12)
                            }
                        }
                        
                        if settings.mixtapesUnlocked {
                            Button(action: {
                                createMixtape()
                                showMenu = false
                            }) {
                                HStack {
                                    Image(systemName: "archivebox")
                                    Text("Save as mixtape")
                                }
                                .font(.system(size: 15))
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 12)
                            }
                        }
                    }
                    .frame(maxWidth: 200)
                    .padding(12)
                    .background(Color.black.opacity(0.9))
                    .cornerRadius(16)
                    .position(x: UIScreen.main.bounds.width - 130, y: 100)
                }
                
                Spacer()
                
                // Album Art Area
                VStack {
                    if let mood = appState.selectedMood {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.black.opacity(0.3))
                                .frame(width: 280, height: 280)
                                .blur(radius: 10)
                            
                            Text(mood.icon)
                                .font(.system(size: 80))
                                .opacity(0.8)
                        }
                        .scaleEffect(appState.isPlaying ? 1.02 : 1.0)
                        .animation(.easeInOut(duration: 3.0).repeatForever(autoreverses: true), value: appState.isPlaying)
                        
                        if settings.showLyricWarnings,
                           let track = currentTrack,
                           track.features.valence < 0.4 {
                            HStack(spacing: 6) {
                                Image(systemName: "exclamationmark.triangle")
                                Text("Heavy themes")
                            }
                            .font(.system(size: 12))
                            .foregroundColor(.white.opacity(0.7))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.black.opacity(0.3))
                            .cornerRadius(12)
                            .padding(.top, 20)
                        }
                    }
                }
                
                Spacer()
                
                // Track Info
                VStack(spacing: 8) {
                    Text(currentTrack?.title ?? "Unknown")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Text(currentTrack?.artist ?? "Unknown Artist")
                        .font(.system(size: 18))
                        .foregroundColor(.white.opacity(0.9))
                    
                    if let album = currentTrack?.album {
                        Text(album)
                            .font(.system(size: 14))
                            .foregroundColor(.white.opacity(0.7))
                    }
                }
                .padding(.bottom, 20)
                
                // Progress Bar
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.white.opacity(0.3))
                            .frame(height: 4)
                        
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.white)
                            .frame(width: geometry.size.width * (appState.progress / 100.0), height: 4)
                    }
                }
                .frame(height: 4)
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
                
                // Controls
                HStack(spacing: 40) {
                    Button(action: {
                        toggleLike()
                    }) {
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .foregroundColor(.white)
                            .font(.system(size: 32))
                            .scaleEffect(isLiked ? 1.2 : 1.0)
                            .animation(.spring(response: 0.3), value: isLiked)
                    }
                    
                    Button(action: {
                        appState.isPlaying.toggle()
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 80, height: 80)
                            
                            Image(systemName: appState.isPlaying ? "pause.fill" : "play.fill")
                                .foregroundColor(.black)
                                .font(.system(size: 32))
                                .offset(x: appState.isPlaying ? 0 : 4)
                        }
                    }
                    
                    Button(action: {
                        handleSkip()
                    }) {
                        Image(systemName: "forward.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 32))
                    }
                }
                .padding(.bottom, 20)
            }
        }
        .onAppear {
            startPlayback()
        }
    }
    
    private func startPlayback() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if appState.isPlaying {
                appState.progress += 0.5
                if appState.progress >= 100 {
                    handleNextTrack()
                }
            }
        }
    }
    
    private func handleSkip() {
        let newSkipCount = appState.skipCount + 1
        appState.skipCount = newSkipCount
        
        if newSkipCount >= 4 {
            appState.isPlaying = false
            appState.currentScreen = .silence
            return
        }
        
        handleNextTrack()
    }
    
    private func handleNextTrack() {
        if appState.currentTrackIndex < appState.currentPlaylist.count - 1 {
            appState.currentTrackIndex += 1
            appState.progress = 0
        } else {
            appState.currentTrackIndex = 0
            appState.progress = 0
        }
    }
    
    private func toggleLike() {
        guard let track = currentTrack else { return }
        if appState.likedTracks.contains(track.id) {
            appState.likedTracks.remove(track.id)
        } else {
            appState.likedTracks.insert(track.id)
        }
    }
    
    private func createMixtape() {
        // Create mixtape from liked tracks
        // Implementation would save to SwiftData
    }
}

