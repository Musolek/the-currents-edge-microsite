// MARK: - Core Models
// Models/Mood.swift

import Foundation
import SwiftUI

struct Mood: Identifiable, Codable, Hashable {
    let id: String
    let label: String
    let icon: String
    let gradientColors: [String]
    let valence: Double  // -1 (negative) to 1 (positive)
    let arousal: Double  // -1 (calm) to 1 (energetic)
    
    var gradient: LinearGradient {
        LinearGradient(
            colors: gradientColors.map { Color(hex: $0) },
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    static let all: [Mood] = [
        Mood(
            id: "radiant",
            label: "Radiant",
            icon: "☀️",
            gradientColors: ["#FFA94D", "#FFD93D"],
            valence: 0.9,
            arousal: 0.85
        ),
        Mood(
            id: "steady",
            label: "Steady",
            icon: "🌤️",
            gradientColors: ["#6BCF9E", "#4A9B7F"],
            valence: 0.7,
            arousal: 0.5
        ),
        Mood(
            id: "pensive",
            label: "Pensive",
            icon: "☁️",
            gradientColors: ["#9B9ECE", "#6B6E9D"],
            valence: 0.45,
            arousal: 0.4
        ),
        Mood(
            id: "heavy",
            label: "Heavy",
            icon: "🌧️",
            gradientColors: ["#5A7A9B", "#3D5A73"],
            valence: 0.25,
            arousal: 0.3
        ),
        Mood(
            id: "restless",
            label: "Restless",
            icon: "⚡",
            gradientColors: ["#E07A5F", "#C85A44"],
            valence: 0.4,
            arousal: 0.75
        ),
        Mood(
            id: "hollow",
            label: "Hollow",
            icon: "🌫️",
            gradientColors: ["#B8B8B8", "#8E8E8E"],
            valence: 0.3,
            arousal: 0.2
        )
    ]
    
    static func from(id: String) -> Mood? {
        all.first { $0.id == id }
    }
}

