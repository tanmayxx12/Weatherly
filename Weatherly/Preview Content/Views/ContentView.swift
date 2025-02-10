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
                
                // Test Data:
                /*
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
                 
                 Text("-----------------------------")
                 
                 Text("date: \(viewModel.weather?.forecast.first?.date.toDateString(format: "dd/MM") ?? "")")
                 Text("formattedDate: \(viewModel.weather?.forecast.first?.date.toDateString(format: "dd MMM") ?? "")")
                 Text("dateText: \(viewModel.weather?.forecast.first?.dateText.formatDateText() ?? "")")
                 Text("sunrise: \(viewModel.weather?.city.sunrise.toDateString(format: "HH:mm") ?? "")")
                 Text("sunset: \(viewModel.weather?.city.sunset.toDateString(format: "HH:mm") ?? "")")

                 Text("temp: \(viewModel.formatTemperature(viewModel.weather?.forecast.first?.main.temp ?? 0))°C")
                 Text("feelsLike: \(viewModel.formatTemperature(viewModel.weather?.forecast.first?.main.feelsLike ?? 0))°C")
                 Text("tempMin: \(viewModel.formatTemperature(viewModel.weather?.forecast.first?.main.tempMin ?? 0))°C")
                 Text("tempMax: \(viewModel.formatTemperature(viewModel.weather?.forecast.first?.main.tempMax ?? 0))°C")
                 Text("wind: \(viewModel.formatWindSpeed(viewModel.weather?.forecast.first?.wind.speed ?? 0)) m/s")
                 Text("description: \(viewModel.weather?.forecast.first?.weather.first?.description ?? "")")
                 */
               
                List(viewModel.locationsArray, id: \.city.id) { weather in
                    NavigationLink {
                        Text("More information on: \(weather.city.name)")
                    } label: {
                        ListRowView(weather: weather, viewModel: viewModel)
                    }
                    
                }
                
                
                
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

struct ListRowView: View {
    let weather: WeatherDataModel
    let viewModel: WeatherViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("\(weather.city.name)")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("\(weather.forecast.first?.date.toDateString(format: "HH:mm") ?? "")")
                
                Spacer()
                
                Text("\(weather.forecast.first?.weather.first?.description.capitalized ?? "")")
            }
            
            Spacer()
            
            VStack {
                Text("\(viewModel.formatTemperature(weather.forecast.first?.main.temp ?? 0))°")
                    .font(.largeTitle)
                Spacer()
                
                HStack {
                    Text("H: \(viewModel.formatTemperature(weather.forecast.first?.main.tempMax ?? 0))°")
                    Text("H: \(viewModel.formatTemperature(weather.forecast.first?.main.tempMax ?? 0))°")
                }
                
            }
            
        }
    }
}
