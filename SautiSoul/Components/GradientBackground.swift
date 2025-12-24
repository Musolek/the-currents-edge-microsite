// MARK: - Gradient Background Component
// Components/GradientBackground.swift

import SwiftUI

struct GradientBackground: View {
    let mood: Mood?
    
    var body: some View {
        if let mood = mood {
            mood.gradient
                .ignoresSafeArea()
        } else {
            LinearGradient(
                colors: [Color(hex: "#1a1a2e"), Color(hex: "#0f0f1e")],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        }
    }
}

