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
            VStack(alignment: .leading) {
                
                
                Text(viewModel.weather?.city.name ?? "")
                Text("date: \(viewModel.weather?.forecast.first?.date ?? 0)")
                Text("sunrise: \(viewModel.weather?.city.sunrise ?? 0)")
                Text("sunset: \(viewModel.weather?.city.sunset ?? 0)")
                Text("temp: \(viewModel.weather?.forecast.first?.main.temp ?? 0)°C")
                Text("feelsLike: \(viewModel.weather?.forecast.first?.main.feelsLike ?? 0)°C")
                Text("tempMin: \(viewModel.weather?.forecast.first?.main.tempMin ?? 0)°C")
                Text("tempMax: \(viewModel.weather?.forecast.first?.main.tempMax ?? 0)°C")
                Text("humidity: \(viewModel.weather?.forecast.first?.main.humidity ?? 0)")
                Text("wind: \(viewModel.weather?.forecast.first?.wind.speed ?? 0)m/s")
                Text("description: \(viewModel.weather?.forecast.first?.weather.first?.description ?? "")")
                
                
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
