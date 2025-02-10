//
//  DetailView.swift
//  Weatherly
//
//  Created by Tanmay . on 10/02/25.
//

import SwiftUI

struct DetailView: View {
    let weather: WeatherDataModel
    let viewModel: WeatherViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 10) {
                    // MARK: Top Weather View
                    TopWeatherView(weather: weather, viewModel: viewModel)
                    
                    // MARK: Horizontal Scroll View (Hourly Forecast):
                    /*
                     ScrollView(.horizontal) {
                        Text("Hourly Forecast will come here")
                     }
                     .frame(height: 120)
                     .frame(maxWidth: .infinity)
                     .background(.ultraThinMaterial)
                     .cornerRadius(10)
                     .padding(.horizontal)
                     */
                   
                    
                    HourlyForecastView(weather: weather, viewModel: viewModel)
                    
                    // MARK: Sunrise/Sunset View
                    SunriseSunsetView(weather: weather)
                    
                    
                    // MARK: Indicators View
                    IndicatorsView(weather: weather, viewModel: viewModel)
                    
                    // MARK: Daily Forecast View
                    DailyForecastView(weather: weather, viewModel: viewModel)
                    
                }
            }
            
        }
    }
}

#Preview {
    DetailView(weather: DeveloperPreview.instance.previewData, viewModel: WeatherViewModel(isPreview: true))
}
