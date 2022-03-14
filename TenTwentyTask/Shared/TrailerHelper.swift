//
//  TrailerHelper.swift
//  TenTwentyTask
//
//  Created by usama on 14/03/2022.
//

import Foundation

enum SourceTypes: String {
    case youtube = "YouTube"
    case vimeo = "Vimeo"
    case none
    
    var baseUrlString: String {
        switch self {
            case .youtube: return "https://www.youtube.com/watch?v="
            case .vimeo: return "https://vimeo.com/"
            case .none: return ""
                
        }
    }
    
    
    func trailerURLString(id: String) -> String {
        String(format: "%@%@", baseUrlString, id)
    }
}
