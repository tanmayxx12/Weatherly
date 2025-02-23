//
//  ListRowView.swift
//  Weatherly
//
//  Created by Tanmay . on 10/02/25.
//

import SwiftUI

struct ListRowView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    let weather: WeatherDataModel
    private var currentWeatherCondition: WeatherCondition? {
        guard let description = weather.forecast.first?.weather.first?.description.lowercased() else {
            return nil
        }
        return WeatherCondition(rawValue: description)
    }
    
    var body: some View {
        ZStack {
            if let condition = currentWeatherCondition {
                Image(condition.backgroundImageName)
                    .resizable()
                    .frame(height: 130)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(20)
                    
            }
            
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
                        Text("L: \(viewModel.formatTemperature(weather.forecast.first?.main.tempMin ?? 0))°")
                    }
                }
            }
            .foregroundStyle(.white)
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(20)
            .frame(height: 100)
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .cornerRadius(20)
        }

    }
        
}

#Preview {
    ListRowView(weather: DeveloperPreview.instance.previewData)
        .environmentObject(WeatherViewModel(isPreview: true))
}
