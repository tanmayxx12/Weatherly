//
//  ContentView.swift
//  Weatherly
//
//  Created by Tanmay . on 08/02/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let weather = viewModel.weatherResponse {
                Text("City: \(weather.city.name)")
                    .font(.headline)
            }
            
            
            
        }
        .task {
            await viewModel.fetchWeather()
        }
    }
}

#Preview {
    ContentView()
}
