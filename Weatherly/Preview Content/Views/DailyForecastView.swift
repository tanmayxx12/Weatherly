//
//  DailyForecastView.swift
//  Weatherly
//
//  Created by Tanmay . on 11/02/25.
//

import SwiftUI

struct DailyForecastView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    let weather: WeatherDataModel
    
    var body: some View {
        
        let sortedDailyForecasts = viewModel.dailyForecasts.sorted { $0.day < $1.day }
        
         ForEach(sortedDailyForecasts, id: \.day) { dailyForecast in
             HStack {
                 HStack(alignment: .center) {
                     Spacer()
                     Text("\(dailyForecast.day.formatDateText(fromFormat: "yyyy-MM-dd", toFormat: "EEEE"))")
                     Spacer()
                 }
                 
                 Spacer()
             
                 HStack {
                     AsyncImage(url: weather.forecast.first?.weather.first?.weatherIconURL) { image in
                         image
                             .resizable()
                             .frame(width: 50, height: 50)
                             .shadow(radius: 5, x: 0, y: 4)
                     } placeholder: {
                         ProgressView()
                     }
                     Text("\(dailyForecast.main.capitalized)")
                 }
                
                 Spacer()
                 
                 HStack {
                     Spacer()
                     Text("\(viewModel.formatTemperature(dailyForecast.maxTemp))°")
                         .foregroundStyle(.red)
                         .fontWeight(.semibold)
                     
                     Text("\(viewModel.formatTemperature(dailyForecast.minTemp))°")
                         .foregroundStyle(.blue)
                         .fontWeight(.semibold)
                     Spacer()
                 }
             }
             .frame(width: 370)
             .background(.ultraThinMaterial)
             .cornerRadius(10)
         }
    }
}

#Preview {
    DailyForecastView(weather: DeveloperPreview.instance.previewData)
        .environmentObject(WeatherViewModel(isPreview: true))
}
