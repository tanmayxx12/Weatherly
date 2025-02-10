//
//  IndicatorsView.swift
//  Weatherly
//
//  Created by Tanmay . on 11/02/25.
//

import SwiftUI

struct IndicatorsView: View {
    let weather: WeatherDataModel
    let viewModel: WeatherViewModel
    
    var body: some View {
        HStack {
            // 1. Feels Like:
            VStack(alignment: .center) {
                HStack {
                    Image(systemName: "thermometer.medium")
                        .font(.title3)
                    
                    Text("Feels Like")
                        .fontWeight(.semibold)
                    
                }
                
                Text("\(viewModel.formatTemperature(weather.forecast.first?.main.feelsLike ?? 0))°")
                    .font(.title)
                    .bold()
                    .padding(.top, 5)
            }
            .frame(width: 110, height: 120)
            .padding(.horizontal, 5)
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            .padding(.horizontal, 2)
            .padding(.leading)
            
            // 2. Humidity:
            VStack(alignment: .center) {
                HStack {
                    Image(systemName: "humidity.fill")
                        .font(.title3)
                    
                    Text("Humidity")
                        .fontWeight(.semibold)
                    
                }
                
                Text("\(weather.forecast.first?.main.humidity ?? 0)%")
                    .font(.title)
                    .bold()
                    .padding(.top, 5)
            }
            .frame(width: 110, height: 120)
            .padding(.horizontal, 5)
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            .padding(.horizontal, 2)
            
            // 3. Wind
            VStack(alignment: .center) {
                HStack {
                    Image(systemName: "wind")
                        .font(.title3)
                    
                    Text("Wind")
                        .fontWeight(.semibold)
                    
                }
                
                Text("\(viewModel.formatWindSpeed(weather.forecast.first?.wind.speed ?? 0) )m/s")
                    .font(.title)
                    .bold()
                    .padding(.top, 5)
            }
            .frame(width: 110, height: 120)
            .padding(.horizontal, 5)
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            .padding(.horizontal, 2)
            .padding(.trailing)
        }
    }
}

#Preview {
    IndicatorsView(weather: DeveloperPreview.instance.previewData, viewModel: WeatherViewModel(isPreview: true))
}
