//
//  WeatherDataModel.swift
//  Weatherly
//
//  Created by Tanmay . on 08/02/25.
//

import Foundation

struct WeatherDataModel: Codable {
    let cod: String
    let message: Int
    let cnt: Int
    let forecast: [Forecast]
    var city: City // changed from let to var so as to override the data coming from the server

    enum CodingKeys: String, CodingKey {
        case cod, message, cnt, city
        case forecast = "list"
    }
    
    // MARK: City
    struct City: Codable {
        let id: Int
        var name: String // changed from let to var so as to override the data coming from the server
        let coordinates: Coordinates
        let country: String
        let population: Int
        let timezone: Int
        let sunrise: Int
        let sunset: Int
        
        enum CodingKeys: String, CodingKey {
            case id, name, country, population, timezone, sunrise, sunset
            case coordinates = "coord"
        }
    }
    
    // MARK: Coordinates
    struct Coordinates: Codable {
        let latitude: Double
        let longitude: Double
        
        enum CodingKeys: String, CodingKey {
            case latitude = "lat"
            case longitude = "lon"
        }
    }
    
    // MARK: Forecast
    struct Forecast: Codable {
        let date: Int 
        let main: MainInfo
        let weather: [Weather]
        let clouds: Clouds
        let wind: Wind
        let visibility: Int?
        let pop: Double // pop means precipitationProbability
        let sys: SystemInfo // sys means system information
        let dateText: String
        let rain: Rain?
        
        enum CodingKeys: String, CodingKey {
            case main, weather, clouds, wind, visibility, pop, sys, rain
            case date = "dt"
            case dateText = "dt_txt"
        }
    }
    
    // MARK: Main Info
    struct MainInfo: Codable {
        let temp: Double
        let feelsLike: Double
        let tempMin: Double
        let tempMax: Double
        let pressure: Int
        let seaLevel: Int
        let groundLevel: Int
        let humidity: Int
        let tempKf: Double
        
        enum CodingKeys: String, CodingKey {
            case temp, pressure, humidity
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case seaLevel = "sea_level"
            case groundLevel = "grnd_level"
            case tempKf = "temp_kf"
        }
    }
    
    // MARK: Weather
    struct Weather: Codable {
        let id: Int
        let condition: String  //WeatherCondition
        let description: String // Description
        let icon: String  // WeatherIcon
        var weatherIconURL: URL{
            let urlString = "https://openweathermap.org/img/wn/\(icon)@2x.png"
            return URL(string: urlString)!
        }
        
        enum CodingKeys: String, CodingKey {
            case id, description, icon
            case condition = "main"
        }
    }
    
    // MARK: Cloud Coverage
    struct Clouds: Codable {
        let percentage: Int
        
        enum CodingKeys: String, CodingKey {
            case percentage = "all"
        }
    }
    
    // MARK: Wind
    struct Wind: Codable {
        let speed: Double
        let direction: Int
        let gust: Double
        
        enum CodingKeys: String, CodingKey {
            case speed, gust
            case direction = "deg"
        }
    }
    
    // MARK: SystemInfo
    struct SystemInfo: Codable {
        let pod: PartOfDay
    }
    
    // MARK: Rain
    struct Rain: Codable {
        let last3Hours: Double
        
        enum CodingKeys: String, CodingKey {
            case last3Hours = "3h"
        }
    }
    
    // MARK: Enums
    enum PartOfDay: String, Codable {
        case day = "d"
        case night = "n"
    }
}
