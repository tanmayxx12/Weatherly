//
//  HourlyForecastView.swift
//  Weatherly
//
//  Created by Tanmay . on 11/02/25.
//

import SwiftUI

struct HourlyForecastView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    let weather: WeatherDataModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(weather.forecast.prefix(10), id: \.date) { hourly in
                    VStack(spacing: 8) {
                        // Time
                        Text(hourly.dateText.formatDateText(toFormat: "HH:mm"))
                            .font(.caption)
                        
                        // Weather Icon
                        AsyncImage(url: hourly.weather.first?.weatherIconURL) { image in
                            image
                                .resizable()
                                .frame(width: 40, height: 40)
                        } placeholder: {
                            ProgressView()
                        }
                        .shadow(radius: 5, x: 0, y: 4)

                        // Temperature
                        Text("\(viewModel.formatTemperature(hourly.main.temp))°")
                            .font(.title2)
                            .bold()
                        
                        // Humidity
                        HStack(spacing: 2) {
                            Image(systemName: "humidity.fill")
                                .foregroundColor(.blue)
                            Text("\(hourly.main.humidity)%")
                                .font(.caption)
                        }
                    }
                    .frame(width: 70, height: 120)
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                }
            }
            .padding(.horizontal)
        }
        .frame(height: 140)
    }
}

#Preview {
    HourlyForecastView(weather: DeveloperPreview.instance.previewData)
        .environmentObject(WeatherViewModel(isPreview: true))
}
