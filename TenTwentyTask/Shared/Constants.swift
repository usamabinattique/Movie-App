//
//  Constants.swift
//  WeatherTask
//
//  Created by usama on 11/03/2022.
//


import UIKit

struct Constants {
    
    static let baseUrl = "https://api.themoviedb.org/3/movie/upcoming"

    static let apiKey = "0e925374ef6e8a50e69ece0fc65463b6"
        
    static let failure = "Failure"
    
    static func imageUrlString(iconCode: String) -> String {
        String(format: "%@%@%@", imageBaseUrl, iconCode, "@2x.png")
    }
}


enum Colors {
    static let theme = UIColor(hex: "10191F")
}
