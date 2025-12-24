// MARK: - Mixtape
// Models/Mixtape.swift

import SwiftData

@Model
class Mixtape {
    @Attribute(.unique) var id: UUID
    var title: String
    var moodID: String
    var trackIDs: [String]
    var createdAt: Date
    var note: String? // Encrypted
    var remindAt: Date?
    
    init(
        id: UUID = UUID(),
        title: String = "Untitled Mixtape",
        moodID: String,
        trackIDs: [String],
        createdAt: Date = Date(),
        note: String? = nil,
        remindAt: Date? = nil
    ) {
        self.id = id
        self.title = title
        self.moodID = moodID
        self.trackIDs = trackIDs
        self.createdAt = createdAt
        self.note = note
        self.remindAt = remindAt
    }
    
    var mood: Mood? {
        Mood.from(id: moodID)
    }
}

