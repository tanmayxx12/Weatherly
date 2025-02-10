//
//  Int.swift
//  Weatherly
//
//  Created by Tanmay . on 10/02/25.
//

import Foundation

// Int extension for date formatting: 
extension Int {
    // Converts UNIX TimeStamp to a formatted date string:
    func toDateString(format: String) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}
