// MARK: - Root View
// App/RootView.swift

import SwiftUI
import SwiftData

struct RootView: View {
    @State private var appState = AppState()
    @State private var settings = AppSettings()
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        Group {
            switch appState.currentScreen {
            case .onboarding:
                OnboardingView(appState: appState, settings: settings)
            case .home:
                HomeView(appState: appState, settings: settings)
            case .context:
                ContextSelectionView(appState: appState, settings: settings)
            case .loading:
                LoadingView(appState: appState)
            case .player:
                PlayerView(appState: appState, settings: settings)
            case .silence:
                SilenceView(appState: appState)
            case .journal:
                JournalView(appState: appState, settings: settings)
            case .thread:
                MoodThreadView(appState: appState, settings: settings)
            case .settings:
                SettingsView(appState: appState, settings: settings)
            case .mixtape:
                MixtapeView(appState: appState, settings: settings)
            }
        }
    }
}

