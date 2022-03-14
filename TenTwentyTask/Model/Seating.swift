//
//  Seating.swift
//  TenTwentyTask
//
//  Created by usama on 14/03/2022.
//

import Foundation

enum SeatingType {
    case text
    case seat
}

struct Seating {
    let number: String
    let type: SeatingType
    let isCenter: Bool
    var isSelected: Bool
    
    init(number: String = "", type: SeatingType, isCenter: Bool) {
        self.number = type == .seat ? "" : number
        self.type = type
        self.isCenter = isCenter
        self.isSelected = false
    }
}
