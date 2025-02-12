//
//  TopWeatherView.swift
//  Weatherly
//
//  Created by Tanmay . on 09/02/25.
//

import SwiftUI

struct TopWeatherView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    let weather: WeatherDataModel
    
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
            
            VStack {
                AsyncImage(url: weather.forecast.first?.weather.first?.weatherIconURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .shadow(radius: 5, x: 0, y: 4)
                } placeholder: {
                    ProgressView()
                }
                
                Spacer()
                
                Text("\(weather.forecast.first?.weather.first?.description.capitalized ?? "")")
                    .font(.headline)
                    .padding(.bottom, 18)
            }
            .padding(.leading)
        }
        .frame(width: 340, height: 130)
        .padding(.horizontal)
        .background(.ultraThinMaterial)
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

#Preview {
    TopWeatherView(weather: DeveloperPreview.instance.previewData)
        .environmentObject(WeatherViewModel(isPreview: true))
}
