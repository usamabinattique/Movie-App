//
//  Formatter.swift
//  WeatherTask
//
//  Created by usama on 03/03/2022.
//

import Foundation


import Foundation

public extension Formatter {
    
    static let standard: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.calendar = Calendar.current
        formatter.dateStyle = .long
        return formatter
    }()
    
    static let yearOnly: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    
    static let apiFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static let apiFormatt: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-dd-MM"
        return formatter
    }()
}
