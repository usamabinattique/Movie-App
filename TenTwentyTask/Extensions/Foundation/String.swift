//
//  String.swift
//  QCSM4
//
//  Created by Yasir Basharat on 27/02/2019.
//  Copyright © 2019 Yasir Basharat. All rights reserved.
//

import Foundation

extension String {


    func isEmptyOrWhitespace() -> Bool {

        if self.isEmpty {
            return true
        }
        return (self.trimmingCharacters(in: NSCharacterSet.whitespaces) == "")
    }

    func date(formatter: DateFormatter = Formatter.standard) -> Date? {
        if let date = formatter.date(from: self) {
            return date
        }
        return nil
    }
}
