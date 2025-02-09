//
//  TopWeatherView.swift
//  Weatherly
//
//  Created by Tanmay . on 09/02/25.
//

import SwiftUI

struct TopWeatherView: View {
    let weather: WeatherDataModel
    
    var body: some View {
        HStack {
            VStack {
                Text(weather.city.name)
                    .font(.headline)
                
                Text(weather.forecast.first?.main.temp.description ?? "")
                
            }
            
            
        }
    }
}

#Preview {
    TopWeatherView(weather: DeveloperPreview.instance.previewData)
}
