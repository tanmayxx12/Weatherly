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
    

    var appError: AppError? = nil
    
    struct AppError: Identifiable {
        let id = UUID().uuidString
        let errorString: String
    }
    
//    init(weather: WeatherDataModel) {
//        self.weather = weather
//    }
    
    
    // Fetches weather data based on latitude and longitude:
    func getWeatherForecast(for location: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMMd, d"
        let apiService = APIService.shared
        
        Task {
            do {
                let placemarks = try await CLGeocoder().geocodeAddressString(location)
                if let latitude = placemarks.first?.location?.coordinate.latitude,
                   let longitude = placemarks.first?.location?.coordinate.longitude {
                    
                    let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=1a363aa93280a7622d9434234fc1f60a&units=metric"
                
                    let weather: WeatherDataModel = try await apiService.getJSON(urlString: urlString, dateDecodingStrategy: .secondsSince1970)
                    DispatchQueue.main.async {
                        self.isLoading = true
                        self.weather = weather
                        
                        // Preventing duplicate locations from being added in the locationsArray:
                        if !self.locationsArray.contains(where: { $0.city.name.lowercased() == weather.city.name.lowercased() }) {
                            self.locationsArray.append(weather)
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
    
}

extension WeatherViewModel {
    
    
    func formatTemperature(_ temp: Double, toFahrenheit: Bool = false) -> String {
        return toFahrenheit ? temp.toFahrenheit() : temp.roundedString
    }
    
    func formatWindSpeed(_ speed: Double) -> String {
        return speed.roundedString
    }
    
    func formateDate(_ timeStamp: Int, format: String) -> String {
        return timeStamp.toDateString(format: format)
    }
    
}


// URL: "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=1a363aa93280a7622d9434234fc1f60a&units=metric"
