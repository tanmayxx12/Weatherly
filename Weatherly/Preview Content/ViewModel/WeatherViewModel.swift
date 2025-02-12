//
//  WeatherViewModel.swift
//  Weatherly
//
//  Created by Tanmay . on 08/02/25.
//

import CoreLocation
import Foundation
import SwiftUI

@MainActor
final class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherDataModel?
    @Published var locationsArray: [WeatherDataModel] = []
    @Published var location: String = ""
    @Published var isLoading: Bool = false
    @AppStorage("location") var storageLocation: String = ""
    @Published var isFahrenheit: Bool = false
    @AppStorage("isFahrenheit") var storedIsFahrenheit: Bool = false
    
    // Adding a new property to store the searched city name:
    @Published var searchedCity: String = ""
    
    var appError: AppError? = nil
    
    struct AppError: Identifiable {
        let id = UUID().uuidString
        let errorString: String
    }
    
    init(isPreview: Bool = false) {
        if isPreview {
            self.weather = DeveloperPreview.instance.previewData
            self.locationsArray = [DeveloperPreview.instance.previewData]
        }
        self.isFahrenheit = storedIsFahrenheit
    }
    
    
    // For Daily Forecasts:
    public struct DailyForecast {
        let day: String
        let maxTemp: Double
        let minTemp: Double
        let main: String
    }
    
    public var dailyForecasts: [DailyForecast] {
        let groupedData = Dictionary(grouping: weather?.forecast ?? [] ) { (element) -> String in
            return String(element.dateText.prefix(10))
        }
        
        return groupedData.compactMap { (key, values) in
            guard let maxTemp = values.max(by: { $0.main.tempMax < $1.main.tempMax }),
                  let minTemp = values.min(by: { $0.main.tempMin < $1.main.tempMin }),
                  let firstWeather = maxTemp.weather.first else {
                return DailyForecast(day: key, maxTemp: 0.0, minTemp: 0.0, main: "unknown")
            }
            return DailyForecast(day: String(key),
                                 maxTemp: maxTemp.main.tempMax,
                                 minTemp: minTemp.main.tempMin,
                                 main: firstWeather.condition)
        }
    }
    
    // Fetches weather data based on latitude and longitude:
    func getWeatherForecast(for location: String) {
        let apiKey: String = "1a363aa93280a7622d9434234fc1f60a"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMMd, d"
        let apiService = APIService.shared
        
        self.searchedCity = location
        
        Task {
            do {
                let placemarks = try await CLGeocoder().geocodeAddressString(location)
                if let latitude = placemarks.first?.location?.coordinate.latitude,
                   let longitude = placemarks.first?.location?.coordinate.longitude {
                    
                    let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
                
                    let weather: WeatherDataModel = try await apiService.getJSON(urlString: urlString, dateDecodingStrategy: .secondsSince1970)
                    DispatchQueue.main.async {
                        self.isLoading = true
                        self.weather = weather
                        
                        // Override the city name with what the user typed:
                        self.weather?.city.name = self.searchedCity
                        
                        // Preventing duplicate locations from being added in the locationsArray:
                        if let modifiedWeather = self.weather ,
                           !self.locationsArray.contains(where: { $0.city.name.lowercased() == modifiedWeather.city.name.lowercased() }) {
                            self.locationsArray.append(modifiedWeather)
                        }
                        
                    }
                }
            } catch let error as CLError {
                DispatchQueue.main.async {
                    self.isLoading = false
                    switch error.code {
                    case .locationUnknown, .geocodeFoundNoResult, .geocodeFoundPartialResult:
                        self.appError = AppError(errorString: "Unable to determine location from this text.")
                    case .network:
                        self.appError = AppError(errorString: "You do not seem to be connected to the network.")
                    default:
                        self.appError = AppError(errorString: "Unknown Error occurred: \(error.localizedDescription)")
                    }
                    print(error.localizedDescription)
                }
            } catch let apiError as APIService.APIError {
                DispatchQueue.main.async{
                    self.isLoading = false
                    if case .error(let errorString) = apiError {
                        self.appError = AppError(errorString: errorString)
                        print(errorString)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.appError = AppError(errorString: error.localizedDescription)
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // Method to delete the item in the list:
    func deleteLocation(at indexSet: IndexSet) {
        locationsArray.remove(atOffsets: indexSet)
    }
    
    // Method to move items in the list:
    func moveLocation(from: IndexSet, to: Int) {
        locationsArray.move(fromOffsets: from, toOffset: to)
    }
    
}

extension WeatherViewModel {
    
    func formatTemperature(_ temp: Double) -> String {
        return isFahrenheit ? temp.toFahrenheit() : temp.roundedString
    }
    
    func formatWindSpeed(_ speed: Double) -> String {
        return speed.roundedString
    }
    
    func formateDate(_ timeStamp: Int, format: String) -> String {
        return timeStamp.toDateString(format: format)
    }
    
}

