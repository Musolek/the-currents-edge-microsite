// MARK: - Design System
// Utils/DesignSystem.swift

import SwiftUI

struct DesignSystem {
    static let primaryGradient = LinearGradient(
        colors: [Color(hex: "#1a1a2e"), Color(hex: "#0f0f1e")],
        startPoint: .top,
        endPoint: .bottom
    )
    
    static let cardCornerRadius: CGFloat = 24
    static let buttonCornerRadius: CGFloat = 24
    static let smallCornerRadius: CGFloat = 12
}

