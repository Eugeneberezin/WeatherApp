//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Eugene Berezin on 12/14/24.
//

import Foundation

// MARK: - WeatherService Protocol
protocol WeatherServiceProtocol {
    func fetchWeather(for city: String, completion: @escaping (Result<CurrentWeatherResponse, Error>) -> Void)
}

// MARK: - WeatherService Implementation
class WeatherService: WeatherServiceProtocol {
    private let apiKey = "0dbcefae663844e5ad2232121241412"
    private let baseURL = "https://api.weatherapi.com/v1"

    func fetchWeather(for city: String, completion: @escaping (Result<CurrentWeatherResponse, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/current.json?key=\(apiKey)&q=\(city)") else {
            completion(.failure(WeatherError.invalidCity))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(WeatherError.networkError))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(WeatherError.noData))
                return
            }

            switch httpResponse.statusCode {
            case 200:
                guard let data = data else {
                    completion(.failure(WeatherError.noData))
                    return
                }
                do {
                    let weatherResponse = try JSONDecoder().decode(CurrentWeatherResponse.self, from: data)
                    completion(.success(weatherResponse))
                } catch {
                    completion(.failure(WeatherError.decodingError))
                }
            case 400:
                completion(.failure(WeatherError.invalidCity))
            case 401:
                completion(.failure(WeatherError.invalidAPIKey))
            case 429:
                completion(.failure(WeatherError.exceededRateLimit))
            default:
                if let data = data,
                   let apiError = try? JSONDecoder().decode(WeatherAPIError.self, from: data) {
                    completion(.failure(WeatherError.unknownError(apiError.error.message)))
                } else {
                    completion(.failure(WeatherError.unknownError("An unknown error occurred.")))
                }
            }
        }
        task.resume()
    }
}

