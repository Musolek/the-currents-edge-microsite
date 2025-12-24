// MARK: - UserDefaults Extension
// Utils/UserDefaults+Helpers.swift

import Foundation

extension UserDefaults {
    /// Returns an optional Bool for a key, allowing distinction between false and missing values
    /// Use this when you need to know if a key exists vs. has a false value
    /// For standard behavior (returns false for missing keys), use the built-in bool(forKey:) method
    func optionalBool(forKey key: String) -> Bool? {
        object(forKey: key) as? Bool
    }
}

