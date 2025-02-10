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
    
    /*
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
     */
    let previewData = WeatherDataModel(
            cod: "200",
            message: 0,
            cnt: 40,
            forecast: [
                WeatherDataModel.Forecast(
                    date: 1739178000,
                    main: WeatherDataModel.MainInfo(
                        temp: 5.24,
                        feelsLike: 5.24,
                        tempMin: 5.24,
                        tempMax: 7.07,
                        pressure: 1026,
                        seaLevel: 1026,
                        groundLevel: 956,
                        humidity: 91,
                        tempKf: -1.83
                    ),
                    weather: [
                        WeatherDataModel.Weather(
                            id: 804,
                            condition: "Clouds",
                            description: "overcast clouds",
                            icon: "04d"
                        )
                    ],
                    clouds: WeatherDataModel.Clouds(percentage: 97),
                    wind: WeatherDataModel.Wind(
                        speed: 0.42,
                        direction: 111,
                        gust: 0.76
                    ),
                    visibility: 10000,
                    pop: 0,
                    sys: WeatherDataModel.SystemInfo(pod: .day),
                    dateText: "2025-02-10 09:00:00",
                    rain: nil
                ),
                WeatherDataModel.Forecast(
                    date: 1739188800,
                    main: WeatherDataModel.MainInfo(
                        temp: 7.9,
                        feelsLike: 7.34,
                        tempMin: 7.9,
                        tempMax: 9.69,
                        pressure: 1025,
                        seaLevel: 1025,
                        groundLevel: 956,
                        humidity: 84,
                        tempKf: -1.79
                    ),
                    weather: [
                        WeatherDataModel.Weather(
                            id: 804,
                            condition: "Clouds",
                            description: "overcast clouds",
                            icon: "04d"
                        )
                    ],
                    clouds: WeatherDataModel.Clouds(percentage: 96),
                    wind: WeatherDataModel.Wind(
                        speed: 1.43,
                        direction: 34,
                        gust: 0.99
                    ),
                    visibility: 10000,
                    pop: 0,
                    sys: WeatherDataModel.SystemInfo(pod: .day),
                    dateText: "2025-02-10 12:00:00",
                    rain: nil
                ),
                WeatherDataModel.Forecast(
                    date: 1739199600,
                    main: WeatherDataModel.MainInfo(
                        temp: 7.12,
                        feelsLike: 7.12,
                        tempMin: 7.12,
                        tempMax: 7.12,
                        pressure: 1025,
                        seaLevel: 1025,
                        groundLevel: 955,
                        humidity: 95,
                        tempKf: 0
                    ),
                    weather: [
                        WeatherDataModel.Weather(
                            id: 500,
                            condition: "Rain",
                            description: "light rain",
                            icon: "10d"
                        )
                    ],
                    clouds: WeatherDataModel.Clouds(percentage: 99),
                    wind: WeatherDataModel.Wind(
                        speed: 0.65,
                        direction: 34,
                        gust: 1.00
                    ),
                    visibility: 10000,
                    pop: 0.2,
                    sys: WeatherDataModel.SystemInfo(pod: .day),
                    dateText: "2025-02-10 15:00:00",
                    rain: WeatherDataModel.Rain(last3Hours: 0.2)
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
                sunrise: 1739168586,
                sunset: 1739205455
            )
        )
    
}

extension DeveloperPreview {
    
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


