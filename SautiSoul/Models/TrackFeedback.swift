// MARK: - User Feedback
// Models/TrackFeedback.swift

import SwiftData

@Model
class TrackFeedback {
    @Attribute(.unique) var id: UUID
    var trackID: String
    var moodID: String
    var contextID: String?
    var action: FeedbackAction
    var timestamp: Date
    var playDuration: TimeInterval // How long they listened
    
    enum FeedbackAction: String, Codable {
        case skip
        case like
        case replay
        case completed // Played to end
    }
    
    init(
        id: UUID = UUID(),
        trackID: String,
        moodID: String,
        contextID: String? = nil,
        action: FeedbackAction,
        timestamp: Date = Date(),
        playDuration: TimeInterval = 0
    ) {
        self.id = id
        self.trackID = trackID
        self.moodID = moodID
        self.contextID = contextID
        self.action = action
        self.timestamp = timestamp
        self.playDuration = playDuration
    }
    
    // Score for recommendation learning
    var score: Double {
        switch action {
        case .skip: return playDuration < 30 ? -1.0 : -0.5
        case .like: return 1.0
        case .replay: return 1.5
        case .completed: return 0.8
        }
    }
}

