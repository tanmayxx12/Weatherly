//
//  PreviewProvider.swift
//  Weatherly
//
//  Created by Tanmay . on 09/02/25.
//

import Foundation

//extension PreviewProvider {
//
//}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    private init() { }
    
    let previewData = WeatherDataModel(
            cod: "200",
            message: 0,
            cnt: 40,
            forecast: [
                WeatherDataModel.Forecast(
                    date: 1738929600,
                    main: WeatherDataModel.MainInfo(
                        temp: 275.99,
                        feelsLike: 274.26,
                        tempMin: 275.99,
                        tempMax: 277.74,
                        pressure: 1030,
                        seaLevel: 1030,
                        groundLevel: 960,
                        humidity: 87,
                        tempKf: -1.75
                    ),
                    weather: [
                        WeatherDataModel.Weather(
                            id: 804,
                            condition: "Clouds",
                            description: "overcast clouds",
                            icon: "04d"
                        )
                    ],
                    clouds: WeatherDataModel.Clouds(percentage: 100),
                    wind: WeatherDataModel.Wind(
                        speed: 1.78,
                        direction: 57,
                        gust: 1.74
                    ),
                    visibility: 10000,
                    pop: 0,
                    sys: WeatherDataModel.SystemInfo(pod: .day),
                    dateText: "2025-02-07 12:00:00",
                    rain: nil
                )
            ],
            city: WeatherDataModel.City(
                id: 3163858,
                name: "Zocca",
                coordinates: WeatherDataModel.Coordinates(
                    latitude: 44.34,
                    longitude: 10.99
                ),
                country: "IT",
                population: 4593,
                timezone: 3600,
                sunrise: 1738909624,
                sunset: 1738946001
            )
        )
    
}

