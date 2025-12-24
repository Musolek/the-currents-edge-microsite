// MARK: - Context Tag Button Component
// Components/ContextTagButton.swift

import SwiftUI

struct ContextTagButton: View {
    let context: Context
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Text(context.icon)
                    .font(.system(size: 32))
                
                Text(context.label)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding(20)
            .background(Color.white.opacity(0.2))
            .cornerRadius(16)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

