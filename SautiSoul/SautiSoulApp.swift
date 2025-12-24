// MARK: - App Entry Point
// SautiSoulApp.swift

import SwiftUI
import SwiftData

@main
struct SautiSoulApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                .modelContainer(for: [MoodEntry.self, TrackFeedback.self, Mixtape.self])
        }
    }
}

