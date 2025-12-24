// MARK: - Mood Card Component
// Components/MoodCard.swift

import SwiftUI

struct MoodCard: View {
    let mood: Mood
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                Text(mood.icon)
                    .font(.system(size: 48))
                
                Text(mood.label)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 40)
            .padding(.horizontal, 20)
            .background(mood.gradient)
            .cornerRadius(24)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

