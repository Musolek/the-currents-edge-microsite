// MARK: - Silence View
// Views/SilenceView.swift

import SwiftUI

struct SilenceView: View {
    @Bindable var appState: AppState
    
    var body: some View {
        ZStack {
            if let mood = appState.selectedMood {
                mood.gradient
                    .ignoresSafeArea()
            }
            
            VStack(spacing: 60) {
                // Back button
                HStack {
                    Button(action: {
                        appState.currentScreen = .home
                    }) {
                        Image(systemName: "xmark")
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
                
                Text("Sometimes the right sound is no sound. Want a moment of quiet?")
                    .font(.system(size: 24, weight: .light, design: .serif))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineSpacing(8)
                    .padding(.horizontal, 40)
                    .italic()
                
                HStack(spacing: 16) {
                    Button(action: {
                        appState.skipCount = 0
                        appState.currentScreen = .player
                        appState.isPlaying = true
                    }) {
                        Text("No, keep going")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)
                            .padding(.horizontal, 32)
                            .padding(.vertical, 16)
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(24)
                    }
                    
                    Button(action: {
                        appState.currentScreen = .home
                    }) {
                        Text("Yes, pause")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 32)
                            .padding(.vertical, 16)
                            .background(Color.white.opacity(0.2))
                            .overlay(
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                    }
                }
                
                Spacer()
            }
        }
    }
}

