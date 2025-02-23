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
    @State var showAlert: Bool = false
    
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
                    .padding(.vertical, 4)
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                .listStyle(.plain)
                .padding(.horizontal, 6)
                
            }
            .navigationTitle("Weather")
            .alert("Error", isPresented: $showAlert) {
                Button("Okay", role: .cancel) {}
            } message: {
                Text("Please enter a valid location.")
                    .font(.headline)
            }
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
                let trimmedLocation = location.trimmingCharacters(in: .whitespacesAndNewlines)
                if trimmedLocation.count < 3 {
                    viewModel.appError = WeatherViewModel.AppError(errorString: "Please enter a valid location")
                    showAlert.toggle()
                } else {
                    Task {
                        viewModel.getWeatherForecast(for: location)
                    }
                }
                
                
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(WeatherViewModel(isPreview: true))
}


