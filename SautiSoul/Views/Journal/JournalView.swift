// MARK: - Journal View
// Views/Journal/JournalView.swift

import SwiftUI

struct JournalView: View {
    @Bindable var appState: AppState
    @Bindable var settings: AppSettings
    @State private var journalText = ""
    
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
                    .padding(.leading, 40)
                    .padding(.top, 40)
                    
                    Spacer()
                }
                
                Spacer()
                
                VStack(spacing: 16) {
                    Text("What happened today? No pressure.")
                        .font(.system(size: 24, weight: .light, design: .serif))
                        .foregroundColor(.white)
                        .italic()
                        .padding(.bottom, 16)
                    
                    TextEditor(text: $journalText)
                        .scrollContentBackground(.hidden)
                        .background(Color.white.opacity(0.05))
                        .foregroundColor(.white)
                        .frame(minHeight: 200)
                        .padding(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white.opacity(0.2), lineWidth: 1)
                        )
                        .cornerRadius(12)
                    
                    HStack(spacing: 8) {
                        Image(systemName: "lock")
                        Text("Stays on your device")
                    }
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.5))
                    .padding(.bottom, 32)
                    
                    HStack(spacing: 16) {
                        Button(action: {
                            saveJournal()
                        }) {
                            Text("Save for me")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.black)
                                .padding(.horizontal, 32)
                                .padding(.vertical, 16)
                                .background(Color.white)
                                .cornerRadius(24)
                        }
                        
                        Button(action: {
                            journalText = ""
                            appState.currentScreen = .home
                        }) {
                            Text("Skip")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 32)
                                .padding(.vertical, 16)
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(24)
                        }
                    }
                }
                .padding(.horizontal, 40)
                .frame(maxWidth: 600)
                
                Spacer()
            }
        }
    }
    
    private func saveJournal() {
        // Save journal entry to SwiftData
        // Implementation would create MoodEntry with journalText
        journalText = ""
        appState.currentScreen = .home
    }
}

