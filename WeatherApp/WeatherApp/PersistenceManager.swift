//
//  PersistenceManager.swift
//  WeatherApp
//
//  Created by Eugene Berezin on 12/14/24.
//

import Foundation

// MARK: - Protocol for Persistence
protocol PersistenceManagerProtocol {
    func saveCity(_ city: String)
    func loadCity() -> String?
}

// MARK: - UserDefaults Implementation
class PersistenceManager: PersistenceManagerProtocol {
    private let selectedCityKey = "selectedCity"

    func saveCity(_ city: String) {
        UserDefaults.standard.set(city, forKey: selectedCityKey)
    }

    func loadCity() -> String? {
        UserDefaults.standard.string(forKey: selectedCityKey)
    }
}

