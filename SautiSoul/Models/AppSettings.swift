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
        // Use standard bool(forKey:) which returns false for missing keys
        // Check if key exists to determine if we should use the stored value or default
        if UserDefaults.standard.object(forKey: "suggestMoodShifts") != nil {
            self.suggestMoodShifts = UserDefaults.standard.bool(forKey: "suggestMoodShifts")
        } else {
            self.suggestMoodShifts = true
        }
        
        if UserDefaults.standard.object(forKey: "enableContextTags") != nil {
            self.enableContextTags = UserDefaults.standard.bool(forKey: "enableContextTags")
        } else {
            self.enableContextTags = false
        }
        
        if UserDefaults.standard.object(forKey: "showLyricWarnings") != nil {
            self.showLyricWarnings = UserDefaults.standard.bool(forKey: "showLyricWarnings")
        } else {
            self.showLyricWarnings = true
        }
        
        if UserDefaults.standard.object(forKey: "enableHealthKit") != nil {
            self.enableHealthKit = UserDefaults.standard.bool(forKey: "enableHealthKit")
        } else {
            self.enableHealthKit = false
        }
        
        let serviceRaw = UserDefaults.standard.string(forKey: "preferredMusicService") ?? "appleMusic"
        self.preferredMusicService = MusicServiceType(rawValue: serviceRaw) ?? .appleMusic
        
        if UserDefaults.standard.object(forKey: "hasCompletedOnboarding") != nil {
            self.hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
        } else {
            self.hasCompletedOnboarding = false
        }
        
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

