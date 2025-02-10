//
//  SunriseSunsetView.swift
//  Weatherly
//
//  Created by Tanmay . on 11/02/25.
//

import SwiftUI

struct SunriseSunsetView: View {
    let weather: WeatherDataModel
    
    var body: some View {
        HStack(spacing: 5) {
            Text("Sunrise")
                .font(.title3)
                .bold()
            
            Image(systemName: "sunrise.fill")
                .foregroundStyle(.yellow)
                .font(.title3)
            
            Text("\(weather.city.sunrise.toDateString(format: "HH:mm"))")
                .bold()
            
            Spacer()
            
            Text("Sunset")
                .font(.title3)
                .bold()
            
            Image(systemName: "sunset.fill")
                .foregroundStyle(.orange)
                .font(.title3)
            
            Text("\(weather.city.sunset.toDateString(format: "HH:mm"))")
                .bold()
            
        }
        .frame(height: 60)
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .background(.ultraThinMaterial)
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

#Preview {
    SunriseSunsetView(weather: DeveloperPreview.instance.previewData)
}
