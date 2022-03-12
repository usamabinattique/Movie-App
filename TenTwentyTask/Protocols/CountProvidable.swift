//
//  CountProvidable.swift
//  AT
//
//  Created by usama on 31/07/2021.
//

import Foundation

protocol CountProvidable {
    func getPageCount(count: Int, pageSize: Int) -> Int
}

extension CountProvidable {

    func getPageCount(count: Int, pageSize: Int) -> Int {
        return (Float(count)/Float(pageSize)).roundToInt()
    }
}


