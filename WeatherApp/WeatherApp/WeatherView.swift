//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Eugene Berezin on 12/14/24.
//


import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel(
        weatherService: WeatherService(),
        persistenceManager: PersistenceManager()
    )
    @State private var citySearch: String = ""

    var body: some View {
        ZStack(alignment: .top) {
            // Background Color
            Color.white
                .ignoresSafeArea()

            VStack {
                // Fixed Search Bar
                HStack {
                    TextField("Search Location", text: $citySearch, onCommit: {
                        viewModel.fetchWeather(for: citySearch)
                    })
                    .padding(.vertical, 12)
                    .padding(.horizontal, 15)
                    .background(Color(.systemGray6))
                    .cornerRadius(15)
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                    .overlay(
                        HStack {
                            Spacer()
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .padding(.trailing, 15)
                        }
                    )
                }
                .padding(.horizontal)
                .padding(.top, 10) // Keeps search bar close to the top

                Spacer() // Push everything else to the center

                // Conditional Rendering for Empty State or Weather Content
                if viewModel.cityName == "No City Selected" {
                    // Empty State View
                    VStack(spacing: 10) {
                        Text("No City Selected")
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)

                        Text("Please Search For A City")
                            .font(.body)
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                } else {
                    // Weather Content
                    VStack {
                        // Weather Icon
                        if let iconURL = viewModel.conditionIconURL {
                            AsyncImage(url: iconURL) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120, height: 120) // Smaller, proportional icon
                            } placeholder: {
                                ProgressView()
                            }
                        }

                        // City Name
                        HStack {
                            Text(viewModel.cityName)
                                .font(.largeTitle)
                                .fontWeight(.bold)

                            Image(systemName: "location.fill")
                                .foregroundColor(.gray)
                                .offset(y: 2)
                        }

                        // Temperature
                        Text(viewModel.temperature)
                            .font(.system(size: 70)) // Reduced size for tighter layout
                            .fontWeight(.bold)

                        // Weather Condition
                        Text(viewModel.condition)
                            .font(.title3)
                            .foregroundColor(.gray)
                    }

                    Spacer() // Push content to center, balanced by the top spacer

                    // Weather Details Section
                    HStack {
                        WeatherDetail(label: "Humidity", value: viewModel.humidity)
                        Spacer()
                        WeatherDetail(label: "UV Index", value: viewModel.uvIndex)
                        Spacer()
                        WeatherDetail(label: "Feels Like", value: viewModel.feelsLike)
                    }
                    .padding(.vertical, 15)
                    .padding(.horizontal, 10)
                    .background(Color(.systemGray6))
                    .cornerRadius(15) // Rounded container for details
                    .padding(.horizontal, 20)
                }

                Spacer() // Padding at the bottom for breathing room
            }
        }
    }
}

struct WeatherDetail: View {
    let label: String
    let value: String

    var body: some View {
        VStack(spacing: 5) {
            Text(label)
                .font(.caption)
                .foregroundColor(.gray)
            Text(value)
                .font(.headline)
                .fontWeight(.semibold)
        }
    }
}
