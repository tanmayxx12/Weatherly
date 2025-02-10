//
//  String.swift
//  Weatherly
//
//  Created by Tanmay . on 10/02/25.
//

import Foundation

extension String {
    // Converts a string date to a formatted string date:
    func formatDateText(fromFormat: String = "yyyy-MM-dd HH:mm:ss", toFormat: String = "EEEE, dd MMM") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Ensures consistent parsing
        
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = toFormat
            return dateFormatter.string(from: date)
        }
        return self
    }
    
}
