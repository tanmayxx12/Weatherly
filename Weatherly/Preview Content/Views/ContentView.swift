//
//  ContentView.swift
//  Weatherly
//
//  Created by Tanmay . on 08/02/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State var location: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(viewModel.weather?.city.name ?? "")
                
            }
            .navigationTitle("Weather")
            .searchable(text: $location, prompt: "Search for a location...")
            .onSubmit(of: .search) {
                Task {
                    viewModel.getWeatherForecast(for: location)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
