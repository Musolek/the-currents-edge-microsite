// MARK: - Mock Music Service (for development/testing)
// Services/MockMusicService.swift

import Foundation

class MockMusicService: MusicService {
    func search(mood: Mood, context: Context?) async throws -> [Track] {
        // Return mock tracks based on mood
        let mockTracks: [Track] = [
            Track(
                id: "1",
                title: "Golden Hour",
                artist: "JVKE",
                album: "Golden Hour",
                duration: 209,
                artworkURL: nil,
                features: AudioFeatures(
                    energy: 0.85,
                    valence: 0.9,
                    danceability: 0.7,
                    tempo: 120,
                    loudness: -5,
                    acousticness: 0.3,
                    instrumentalness: 0.0
                ),
                serviceType: .appleMusic
            )
        ]
        
        return mockTracks
    }
    
    func getAudioFeatures(trackID: String) async throws -> AudioFeatures {
        return AudioFeatures(
            energy: 0.5,
            valence: 0.5,
            danceability: 0.5,
            tempo: 120,
            loudness: -10,
            acousticness: 0.5,
            instrumentalness: 0.0
        )
    }
    
    func play(track: Track) async throws {
        // Mock implementation
    }
    
    func pause() async throws {
        // Mock implementation
    }
    
    func skip() async throws {
        // Mock implementation
    }
}

