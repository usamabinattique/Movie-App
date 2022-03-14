//
//  Constants.swift
//  WeatherTask
//
//  Created by usama on 11/03/2022.
//


import UIKit

struct Constants {
    
    static let baseUrl = "https://api.themoviedb.org/3/"

    static let apiKey = "0e925374ef6e8a50e69ece0fc65463b6"
        
    static let failure = "Failure"
    
    static let imageBaseUrl = "http://image.tmdb.org/t/p/w500/"
    
    static func imageUrlString(iconCode: String) -> String {
        String(format: "%@%@", imageBaseUrl, iconCode)
    }
}


enum Colors {
    static let theme = UIColor(hex: "10191F")
}
