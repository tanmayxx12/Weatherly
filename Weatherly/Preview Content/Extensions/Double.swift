//
//  Double.swift
//  Weatherly
//
//  Created by Tanmay . on 10/02/25.
//

import Foundation

extension Double {
    // Rounds a double to the nearest whole number:
    var roundedString: String {
        return String(format: "%.0f", self)
    }
    
    // Converts Celsius to Fahrenheit:
    func toFahrenheit() -> String {
        let fahrenheit = (self * 9/5) + 32
        return String(format: "%.0f", fahrenheit)
    }
}
