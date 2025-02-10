//
//  DetailView.swift
//  Weatherly
//
//  Created by Tanmay . on 10/02/25.
//

import SwiftUI

struct DetailView: View {
    let weather: WeatherDataModel
    let viewModel: WeatherViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 10) {
                    // MARK: Top Weather View
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
                    
                    // MARK: Horizontal Scroll View (Hourly Forecast):
                    HStack{
                        Text("Hourly Forecast will come here")
                    }
                    .frame(height: 120)
                    .frame(maxWidth: .infinity)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    
                    // MARK: Sunrise/Sunset View
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
                    
                    
                    // MARK: Indicators View
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
                    
                    // MARK: Daily Forecast View
                    ForEach(viewModel.dailyForecasts, id: \.day) { dailyForecast in
                        HStack {
                            
                            Text("\(dailyForecast.day.formatDateText(fromFormat: "yyyy-MM-dd", toFormat: "EEEE"))")
                            
                            Spacer()
                            
                            AsyncImage(url: weather.forecast.first?.weather.first?.weatherIconURL) { image in
                                image
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            } placeholder: {
                                ProgressView()
                            }
//                            Text("\(weather.forecast.first?.weather.first?.condition ?? "")")
                            Text("\(dailyForecast.main.capitalized)")
                            
                            Spacer()
                            
                            Text("\(viewModel.formatTemperature(dailyForecast.maxTemp))°")
                                .foregroundStyle(.red)
                                .fontWeight(.semibold)
                            
                            Text("\(viewModel.formatTemperature(dailyForecast.minTemp))°")
                                .foregroundStyle(.blue)
                                .fontWeight(.semibold)
                            
                        }
                        .padding(.vertical, 4)
                        .padding(.horizontal, 5)
                        .background(.ultraThinMaterial)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    }
                    
                    
                    
                  
                    
                    
                    
                    
                }
            }
            
        }
    }
}

#Preview {
    DetailView(weather: DeveloperPreview.instance.previewData, viewModel: WeatherViewModel(isPreview: true))
}
