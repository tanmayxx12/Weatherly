//
//  ContentView.swift
//  Weatherly
//
//  Created by Tanmay . on 08/02/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    @State var location: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                List{
                    ForEach(viewModel.locationsArray, id: \.city.id) { weather in
                        NavigationLink {
                            DetailView(weather: weather)
                        } label: {
                            ListRowView(weather: weather)
                        }
                    }
                    .onDelete(perform: viewModel.deleteLocation)
                    .onMove(perform: viewModel.moveLocation)
                }
                .listStyle(.insetGrouped)
                
            }
            .navigationTitle("Weather")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        // Edit Button:
                        EditButton()
                        
                        Divider()
                        
                        // Celsius Button
                        Button {
                            viewModel.isFahrenheit = false
                        } label: {
                            HStack {
                                Text("Celsius")
                                Spacer()
                                Image(systemName: "degreesign.celsius")
                            }
                            .font(.headline)
                        }
                        
                        // Fahrenheit Button
                        Button {
                            viewModel.isFahrenheit = true
                        } label: {
                            HStack {
                                Text("Fahrenheit")
                                Spacer()
                                Image(systemName: "degreesign.fahrenheit")
                            }
                            .font(.headline)
                        }

                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .foregroundStyle(.primary)
                    }
                }
            }
            .searchable(text: $location, prompt: "Search for a city")
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
        .environmentObject(WeatherViewModel(isPreview: false))
}


