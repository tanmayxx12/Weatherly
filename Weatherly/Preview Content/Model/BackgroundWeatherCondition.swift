//
//  BackgroundWeatherCondition.swift
//  Weatherly
//
//  Created by Tanmay . on 11/02/25.
//

import Foundation

enum WeatherCondition: String {
    case overcastClouds = "overcast clouds"
    case fewClouds = "few clouds"
    case scatteredClouds = "scattered clouds"
    case brokenClouds = "broken clouds"
    case showerRain = "shower rain"
    case rain = "rain"
    case thunderstorm = "thunderstorm"
    case clearSky = "clear sky"
    case snow = "snow"
    case mist = "mist"
    
    var backgroundImageName: String {
        switch self {
        case .overcastClouds: return "overcastClouds"
        case .fewClouds: return "fewClouds"
        case .scatteredClouds: return "scatteredClouds"
        case .brokenClouds: return "brokenClouds"
        case .showerRain: return "showerRain"
        case .rain: return "rain"
        case .thunderstorm: return "thunderstorm"
        case .clearSky: return "clearSky"
        case .snow: return "snow"
        case .mist: return "mist"
        }
    }
    
}
