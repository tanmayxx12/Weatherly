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
                    Text("L: \(viewModel.formatTemperature(weather.forecast.first?.main.tempMin ?? 0))°")
                }
            }
        }
        .frame(height: 100)
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .cornerRadius(20)
        
    }
}

#Preview {
    ListRowView(weather: DeveloperPreview.instance.previewData)
        .environmentObject(WeatherViewModel(isPreview: true))
}
