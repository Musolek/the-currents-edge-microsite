// MARK: - Mood History
// Models/MoodHistory.swift

import SwiftData

@Model
class MoodEntry {
    @Attribute(.unique) var id: UUID
    var timestamp: Date
    var moodID: String
    var contextID: String?
    var trackIDs: [String]
    var journalText: String? // Encrypted
    
    init(
        id: UUID = UUID(),
        timestamp: Date = Date(),
        moodID: String,
        contextID: String? = nil,
        trackIDs: [String] = [],
        journalText: String? = nil
    ) {
        self.id = id
        self.timestamp = timestamp
        self.moodID = moodID
        self.contextID = contextID
        self.trackIDs = trackIDs
        self.journalText = journalText
    }
    
    var mood: Mood? {
        Mood.from(id: moodID)
    }
}

