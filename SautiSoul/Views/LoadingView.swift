// MARK: - Loading View
// Views/LoadingView.swift

import SwiftUI

struct LoadingView: View {
    @Bindable var appState: AppState
    
    var body: some View {
        ZStack {
            if let mood = appState.selectedMood {
                mood.gradient
                    .ignoresSafeArea()
            }
            
            VStack(spacing: 30) {
                if let mood = appState.selectedMood {
                    Text(mood.icon)
                        .font(.system(size: 64))
                        .scaleEffect(1.0)
                        .animation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true), value: appState.isPlaying)
                }
                
                HStack(spacing: 8) {
                    ForEach(0..<3, id: \.self) { index in
                        Circle()
                            .fill(Color.white)
                            .frame(width: 8, height: 8)
                            .offset(y: index == 1 ? -12 : 0)
                            .animation(
                                .easeInOut(duration: 1.4)
                                .repeatForever()
                                .delay(Double(index) * 0.16),
                                value: index
                            )
                    }
                }
                
                Text("Listening to your weather...")
                    .font(.system(size: 18, weight: .light))
                    .foregroundColor(.white)
            }
        }
    }
}

