//
//  LocalStorage.swift
//  CloudletTracker
//
//  Created by Mark Vialichka on 7/14/19.
//  Copyright © 2019 Mark Vialichka. All rights reserved.
//

import Foundation

enum StorageError: Error {
    case notFound
    case failedEncryption
    case failedDecryption
}

extension StorageError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .notFound:
            return "No value found for given Key value"
        case .failedEncryption:
            return "Failed to encrypt the value for given Key"
        case .failedDecryption:
            return "Failed to decrypt the value for given Key"
        }
    }
}

enum StorageKey: String {
    case fetchedWeatherInfo = "cloudletTracker.localstorage.fetchedWeatherInfo"
    case fetchedForecast = "cloudletTracker.localstorage.fetchedForecast"
}

class LocalStorage {
    private let storage: UserDefaults = UserDefaults.standard

    func setBool(flag: Bool, forKey: StorageKey) {
        storage.set(flag, forKey: forKey.rawValue)
    }

    func getBool(forKey: StorageKey) -> Bool {
        return storage.bool(forKey: forKey.rawValue)
    }

    func setString(string: String, forKey: StorageKey) {
        storage.set(string, forKey: forKey.rawValue)
    }

    func getString(forKey: StorageKey) -> String? {
        return storage.string(forKey: forKey.rawValue)
    }

    func integer(forKey: StorageKey) -> Int {
        return storage.integer(forKey: forKey.rawValue)
    }

    func setInteger(value: Int, forKey: StorageKey) {
        storage.set(value, forKey: forKey.rawValue)
    }

    /// Set Codable object into UserDefaults
    ///
    /// - Parameters:
    ///   - object: Codable Object
    ///   - forKey: Key string
    /// - Throws: UserDefaults Error
    public func set<T: Codable>(object: T, forKey: StorageKey) throws {
        let jsonData = try JSONEncoder().encode(object)
        storage.set(jsonData, forKey: forKey.rawValue)
    }

    ///
    /// - Parameters:
    ///   - object: Codable Object
    ///   - forKey: Key string
    /// - Throws: UserDefaults Error
    public func get<T: Codable>(objectType: T.Type, forKey: StorageKey) throws -> T {
        guard let result = storage.value(forKey: forKey.rawValue) as? Data else {
            throw StorageError.notFound
        }
        return try JSONDecoder().decode(objectType, from: result)
    }

    public func removeObject(forKey: StorageKey) {
        storage.removeObject(forKey: forKey.rawValue)
    }
}
