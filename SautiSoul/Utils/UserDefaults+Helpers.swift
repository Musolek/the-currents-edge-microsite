// MARK: - UserDefaults Extension
// Utils/UserDefaults+Helpers.swift

import Foundation

extension UserDefaults {
    func bool(forKey key: String) -> Bool? {
        object(forKey: key) as? Bool
    }
}

