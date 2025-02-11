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
                
                List(viewModel.locationsArray, id: \.city.id) { weather in
                    NavigationLink {
                        DetailView(weather: weather)
                    } label: {
                        ListRowView(weather: weather)
                    }
                }
                .listStyle(.plain)
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
        .environmentObject(WeatherViewModel(isPreview: true))
}


