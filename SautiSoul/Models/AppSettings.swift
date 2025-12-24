// MARK: - App Settings
// Models/AppSettings.swift

import Foundation

@Observable
class AppSettings {
    var suggestMoodShifts: Bool {
        didSet { UserDefaults.standard.set(suggestMoodShifts, forKey: "suggestMoodShifts") }
    }
    
    var enableContextTags: Bool {
        didSet { UserDefaults.standard.set(enableContextTags, forKey: "enableContextTags") }
    }
    
    var showLyricWarnings: Bool {
        didSet { UserDefaults.standard.set(showLyricWarnings, forKey: "showLyricWarnings") }
    }
    
    var enableHealthKit: Bool {
        didSet { UserDefaults.standard.set(enableHealthKit, forKey: "enableHealthKit") }
    }
    
    var preferredMusicService: MusicServiceType {
        didSet { UserDefaults.standard.set(preferredMusicService.rawValue, forKey: "preferredMusicService") }
    }
    
    var hasCompletedOnboarding: Bool {
        didSet { UserDefaults.standard.set(hasCompletedOnboarding, forKey: "hasCompletedOnboarding") }
    }
    
    var sessionCount: Int {
        didSet { UserDefaults.standard.set(sessionCount, forKey: "sessionCount") }
    }
    
    enum MusicServiceType: String, Codable {
        case appleMusic
        case spotify
    }
    
    init() {
        self.suggestMoodShifts = UserDefaults.standard.bool(forKey: "suggestMoodShifts") ?? true
        self.enableContextTags = UserDefaults.standard.bool(forKey: "enableContextTags") ?? false
        self.showLyricWarnings = UserDefaults.standard.bool(forKey: "showLyricWarnings") ?? true
        self.enableHealthKit = UserDefaults.standard.bool(forKey: "enableHealthKit") ?? false
        
        let serviceRaw = UserDefaults.standard.string(forKey: "preferredMusicService") ?? "appleMusic"
        self.preferredMusicService = MusicServiceType(rawValue: serviceRaw) ?? .appleMusic
        
        self.hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding") ?? false
        self.sessionCount = UserDefaults.standard.integer(forKey: "sessionCount")
    }
    
    // Feature unlock logic
    var contextTagsUnlocked: Bool {
        sessionCount >= 3
    }
    
    var journalingUnlocked: Bool {
        sessionCount >= 5
    }
    
    var moodThreadUnlocked: Bool {
        sessionCount >= 7
    }
    
    var mixtapesUnlocked: Bool {
        sessionCount >= 14
    }
    
    func incrementSessionCount() {
        sessionCount += 1
    }
}

