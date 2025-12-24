// MARK: - Context Tags
// Models/Context.swift

struct Context: Identifiable, Codable, Hashable {
    let id: String
    let label: String
    let icon: String
    
    static let all: [Context] = [
        Context(id: "moving", label: "Moving", icon: "🚶"),
        Context(id: "resting", label: "Resting", icon: "🛋️"),
        Context(id: "working", label: "Working", icon: "🧠"),
        Context(id: "processing", label: "Processing", icon: "🌙"),
        Context(id: "social", label: "Social", icon: "🎉")
    ]
    
    // Context modifiers for recommendation engine
    var energyModifier: Double {
        switch id {
        case "working": return -0.2  // Lower energy for focus
        case "resting": return -0.3   // Much lower energy
        case "social": return 0.2     // Higher energy
        default: return 0.0
        }
    }
    
    var valenceModifier: Double {
        switch id {
        case "social": return 0.15    // More positive
        case "processing": return -0.1 // Allow lower valence
        default: return 0.0
        }
    }
}

