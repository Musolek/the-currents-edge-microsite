// MARK: - App State Management
// App/AppState.swift

import SwiftUI
import SwiftData

@Observable
class AppState {
    var currentScreen: Screen = .onboarding
    var selectedMood: Mood?
    var selectedContext: Context?
    var currentPlaylist: [Track] = []
    var currentTrackIndex: Int = 0
    var isPlaying: Bool = false
    var progress: Double = 0.0
    var skipCount: Int = 0
    var likedTracks: Set<String> = []
    
    enum Screen {
        case onboarding
        case home
        case context
        case loading
        case player
        case silence
        case journal
        case thread
        case settings
        case mixtape
    }
}

