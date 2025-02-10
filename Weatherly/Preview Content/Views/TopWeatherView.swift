//
//  TopWeatherView.swift
//  Weatherly
//
//  Created by Tanmay . on 09/02/25.
//

import SwiftUI

struct TopWeatherView: View {
    let weather: WeatherDataModel
    let viewModel: WeatherViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("\(weather.forecast.first?.dateText.formatDateText() ?? "")")
                
                Text("\(viewModel.formatTemperature(weather.forecast.first?.main.temp ?? 0))°")
                    .font(.largeTitle)
                    .bold()
                
                Text("\(weather.city.name.capitalized)")
                    .font(.title2)
                    .bold()
            }
            
            Spacer()
            
            AsyncImage(url: weather.forecast.first?.weather.first?.weatherIconURL) { image in
                image
                    .frame(width: 120, height: 120)
            } placeholder: {
                ProgressView()
            }
        }
        .frame(height: 130)
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .background(.ultraThinMaterial)
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

#Preview {
    TopWeatherView(weather: DeveloperPreview.instance.previewData, viewModel: WeatherViewModel(isPreview: true))
}
