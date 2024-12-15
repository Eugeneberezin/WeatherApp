//
//  WeatherError.swift
//  WeatherApp
//
//  Created by Eugene Berezin on 12/14/24.
//

import Foundation

// MARK: - WeatherError Enum
enum WeatherError: LocalizedError {
    case invalidCity
    case networkError
    case noData
    case decodingError
    case exceededRateLimit
    case invalidAPIKey
    case unknownError(String)

    var errorDescription: String? {
        switch self {
        case .invalidCity:
            return "The city name is invalid. Please try again."
        case .networkError:
            return "A network error occurred. Please check your internet connection."
        case .noData:
            return "No data was received from the server."
        case .decodingError:
            return "Unable to process the weather data."
        case .exceededRateLimit:
            return "You have exceeded the rate limit. Please wait and try again."
        case .invalidAPIKey:
            return "The API key provided is invalid. Please check your credentials."
        case .unknownError(let message):
            return message
        }
    }
}

// MARK: - WeatherAPI Error Response Model
struct WeatherAPIError: Codable {
    let error: APIError
}

struct APIError: Codable {
    let code: Int
    let message: String
}
