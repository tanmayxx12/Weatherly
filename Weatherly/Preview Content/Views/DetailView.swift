//
//  DetailView.swift
//  Weatherly
//
//  Created by Tanmay . on 10/02/25.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    let weather: WeatherDataModel
    private var currentWeatherCondition: WeatherCondition? {
        guard let description = weather.forecast.first?.weather.first?.description.lowercased() else {
            return nil
        }
        return WeatherCondition(rawValue: description)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // MARK: - Background Layer
                if let condition = currentWeatherCondition {
                    Image(condition.backgroundImageName)
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        .frame(maxWidth: .infinity, maxHeight: .infinity) // Added for the ContentView
                        .overlay {
                            // Semi-transparent overlay for better readability
                            Color.black.opacity(0.3)
                                .ignoresSafeArea()
                        }
                }
                
                // MARK: - Content Layer
                ScrollView {
                    VStack {
                        TopWeatherView(weather: weather)
                        
                        ScrollView(.horizontal) {
                            HourlyForecastView(weather: weather)
                        }
                        .frame(width: 370)
                        
                        SunriseSunsetView(weather: weather)
                        
                        
                        IndicatorsView(weather: weather)
                        
                        DailyForecastView(weather: weather)
                        
                    }
                }
                .scrollIndicators(.hidden) 
            }
            .toolbarBackground(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    DetailView(weather: DeveloperPreview.instance.previewData)
        .environmentObject(WeatherViewModel(isPreview: true))
}
