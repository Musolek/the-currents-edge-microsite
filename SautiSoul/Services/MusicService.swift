// MARK: - Music Service Protocol
// Services/MusicService.swift

import Foundation

protocol MusicService {
    func search(mood: Mood, context: Context?) async throws -> [Track]
    func getAudioFeatures(trackID: String) async throws -> AudioFeatures
    func play(track: Track) async throws
    func pause() async throws
    func skip() async throws
}

