// MARK: - Music Service Factory
// Services/MusicServiceFactory.swift

import Foundation

class MusicServiceFactory {
    static func create(serviceType: AppSettings.MusicServiceType) -> MusicService {
        switch serviceType {
        case .appleMusic:
            return AppleMusicService()
        case .spotify:
            return SpotifyService()
        }
    }
}

