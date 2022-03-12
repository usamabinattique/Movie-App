//
//  Float.swift
//  QCSM4
//
//  Created by Usama Attique on 09/01/2020.
//  Copyright © 2020 Yasir Basharat. All rights reserved.
//

import Foundation

extension Float {

    func roundToInt() -> Int {

        let value = Int(self)
        let fraction = fractions()

        if fraction >= 0.1 {
            return value + 1
        }
        return value
    }

    private func fractions() -> Float {
        
        { modf( self ).1 }().roundTo( places: 2 )
    }

    func roundTo(places: Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}
