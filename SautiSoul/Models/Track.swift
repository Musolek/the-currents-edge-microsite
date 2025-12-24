// MARK: - Track Model
// Models/Track.swift

struct Track: Identifiable, Codable, Hashable {
    let id: String
    let title: String
    let artist: String
    let album: String?
    let duration: TimeInterval
    let artworkURL: URL?
    let features: AudioFeatures
    let serviceType: MusicServiceType
    
    enum MusicServiceType: String, Codable {
        case appleMusic
        case spotify
    }
}

struct AudioFeatures: Codable, Hashable {
    let energy: Double      // 0.0 to 1.0
    let valence: Double     // 0.0 (sad) to 1.0 (happy)
    let danceability: Double
    let tempo: Double       // BPM
    let loudness: Double    // dB
    let acousticness: Double
    let instrumentalness: Double
    
    /// Normalizes valence from 0.0-1.0 range to -1.0-1.0 range to match Mood.valence
    var normalizedValence: Double {
        (valence * 2.0) - 1.0
    }
    
    /// Normalizes energy from 0.0-1.0 range to -1.0-1.0 range to match Mood.arousal
    var normalizedEnergy: Double {
        (energy * 2.0) - 1.0
    }
    
    // Compute emotional distance from a mood
    // Note: Normalizes audio features to match mood's -1.0 to 1.0 range
    func distance(to mood: Mood) -> Double {
        let valenceDiff = normalizedValence - mood.valence
        let energyDiff = normalizedEnergy - mood.arousal
        return sqrt(valenceDiff * valenceDiff + energyDiff * energyDiff)
    }
    
    // Generate feature vector for ML
    var featureVector: [Double] {
        [energy, valence, danceability, tempo / 200.0, (loudness + 60) / 60.0, acousticness, instrumentalness]
    }
}

