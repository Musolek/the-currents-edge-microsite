// MARK: - Settings View
// Views/Settings/SettingsView.swift

import SwiftUI

struct SettingsView: View {
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
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button(action: {
                        appState.currentScreen = .home
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(Color.white.opacity(0.1))
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    Text("Settings")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Color.clear
                        .frame(width: 44, height: 44)
                }
                .padding(.horizontal, 40)
                .padding(.top, 40)
                .padding(.bottom, 40)
                
                ScrollView {
                    VStack(spacing: 32) {
                        // Nudge Preferences
                        VStack(alignment: .leading, spacing: 16) {
                            Text("NUDGE PREFERENCES")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white.opacity(0.5))
                                .letterSpacing(1)
                            
                            SettingsRow(
                                title: "Suggest mood shifts",
                                description: "App may offer slightly brighter songs if you're comfortable.",
                                isOn: $settings.suggestMoodShifts
                            )
                        }
                        .padding(.horizontal, 40)
                        
                        // Features
                        VStack(alignment: .leading, spacing: 16) {
                            Text("FEATURES")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white.opacity(0.5))
                                .letterSpacing(1)
                            
                            SettingsRow(
                                title: "Context tags",
                                description: "Quick tags like 'commuting' or 'processing'.",
                                isOn: $settings.enableContextTags,
                                disabled: !settings.contextTagsUnlocked,
                                unlockText: settings.contextTagsUnlocked ? nil : "Unlocks after 3 sessions"
                            )
                            
                            SettingsRow(
                                title: "Show lyric content warnings",
                                description: "Deprioritize songs with heavy themes when needed.",
                                isOn: $settings.showLyricWarnings
                            )
                        }
                        .padding(.horizontal, 40)
                        
                        // About
                        VStack(spacing: 8) {
                            Text("Sauti Soul v1.0")
                                .font(.system(size: 14))
                                .foregroundColor(.white.opacity(0.5))
                            
                            Text("Built with care. For you, not metrics.")
                                .font(.system(size: 14))
                                .foregroundColor(.white.opacity(0.5))
                        }
                        .padding(.top, 40)
                    }
                }
            }
        }
    }
}

struct SettingsRow: View {
    let title: String
    let description: String
    @Binding var isOn: Bool
    var disabled: Bool = false
    var unlockText: String? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                    
                    Text(description)
                        .font(.system(size: 14))
                        .foregroundColor(.white.opacity(0.6))
                    
                    if let unlockText = unlockText {
                        Text(unlockText)
                            .font(.system(size: 12))
                            .foregroundColor(.white.opacity(0.4))
                            .padding(.top, 4)
                    }
                }
                
                Spacer()
                
                Toggle("", isOn: $isOn)
                    .disabled(disabled)
                    .opacity(disabled ? 0.5 : 1.0)
            }
        }
        .padding(20)
        .background(Color.white.opacity(0.05))
        .cornerRadius(12)
    }
}

