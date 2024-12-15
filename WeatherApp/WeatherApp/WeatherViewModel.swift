//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Eugene Berezin on 12/14/24.
//

import SwiftUI

// MARK: - WeatherViewModel
class WeatherViewModel: ObservableObject {
    @Published var cityName: String = "No City Selected"
    @Published var temperature: String = "--"
    @Published var condition: String = ""
    @Published var conditionIconURL: URL?
    @Published var humidity: String = "--"
    @Published var uvIndex: String = "--"
    @Published var feelsLike: String = "--"
    @Published var errorMessage: String?

    private let weatherService: WeatherServiceProtocol
    private let persistenceManager: PersistenceManagerProtocol

    init(weatherService: WeatherServiceProtocol, persistenceManager: PersistenceManagerProtocol) {
        self.weatherService = weatherService
        self.persistenceManager = persistenceManager

        loadPersistedCity()
    }

    func fetchWeather(for city: String) {
        weatherService.fetchWeather(for: city) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    self?.updateUI(with: weather)
                    self?.persistenceManager.saveCity(city)
                    self?.errorMessage = nil
                case .failure(let error):
                    self?.handleError(error)
                }
            }
        }
    }

    private func handleError(_ error: Error) {
        if let weatherError = error as? WeatherError {
            self.errorMessage = weatherError.localizedDescription
        } else {
            self.errorMessage = WeatherError.unknownError("Something went wrong.").localizedDescription
        }
    }

    private func loadPersistedCity() {
        if let savedCity = persistenceManager.loadCity() {
            fetchWeather(for: savedCity)
        }
    }

    private func updateUI(with weather: CurrentWeatherResponse) {
        cityName = weather.location.name
        temperature = "\(Int(weather.current.tempC))°"
        condition = weather.current.condition.text
        conditionIconURL = URL(string: "https:\(weather.current.condition.icon)")
        humidity = "\(weather.current.humidity)%"
        uvIndex = "\(weather.current.uv)"
        feelsLike = "\(Int(weather.current.feelslikeC))°"
    }
}

