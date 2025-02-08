//
//  WeatherViewModel.swift
//  Weatherly
//
//  Created by Tanmay . on 08/02/25.
//

import Foundation

@MainActor
final class WeatherViewModel: ObservableObject {
    private let apiService = APIService.shared
//    private let apiKey = "1a363aa93280a7622d9434234fc1f60a"
    
    @Published var weatherResponse: WeatherDataModel?
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    func fetchWeather() async {
        isLoading = true
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=44.34&lon=10.99&appid=1a363aa93280a7622d9434234fc1f60a&units=metric"
        
        do {
            let response: WeatherDataModel = try await apiService.getJSON(urlString: urlString)
            self.weatherResponse = response
        } catch let APIService.APIError.error(errorMessage){
            self.errorMessage = errorMessage
        } catch {
            self.errorMessage = "Unexpected error: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}


// URL: "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=1a363aa93280a7622d9434234fc1f60a&units=metric"
