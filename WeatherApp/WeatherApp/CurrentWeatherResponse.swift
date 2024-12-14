//
//  CurrentWeatherResponse.swift
//  WeatherApp
//
//  Created by Eugene Berezin on 12/14/24.
//

import Foundation

// MARK: - Weather API Response Models
struct CurrentWeatherResponse: Codable {
    let location: Location
    let current: Current
}

struct Location: Codable {
    let name: String
    let region: String
    let country: String
}

struct Current: Codable {
    let tempC: Double
    let feelslikeC: Double
    let humidity: Int
    let uv: Double
    let condition: Condition

    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case feelslikeC = "feelslike_c"
        case humidity
        case uv
        case condition
    }
}

struct Condition: Codable {
    let text: String
    let icon: String
}

