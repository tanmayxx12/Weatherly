//
//  WeatherlyApp.swift
//  Weatherly
//
//  Created by Tanmay . on 08/02/25.
//

import SwiftUI

@main
struct WeatherlyApp: App {
    @StateObject private var viewModel = WeatherViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: WeatherViewModel(isPreview: false))
                .environmentObject(viewModel)
        }
    }
}
