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
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 10) {
                    // MARK: Top Weather View
                    TopWeatherView(weather: weather)
                    
                    // MARK: Horizontal Scroll View (Hourly Forecast):
                    HourlyForecastView(weather: weather)
                    
                    // MARK: Sunrise/Sunset View
                    SunriseSunsetView(weather: weather)
                    
                    
                    // MARK: Indicators View
                    IndicatorsView(weather: weather)
                    
                    // MARK: Daily Forecast View
                    DailyForecastView(weather: weather)
                    
                }
            }
        }
    }
}

#Preview {
    DetailView(weather: DeveloperPreview.instance.previewData)
        .environmentObject(WeatherViewModel(isPreview: true))
}
