//
//  UIBarButtonItem.swift
//  TenTwentyTask
//
//  Created by usama on 13/03/2022.
//

import UIKit

extension UIBarButtonItem {

    var isHidden: Bool {
        get {
            return tintColor == .clear
        }
        set {
            tintColor = newValue ? .clear : .white //or whatever color you want
            isEnabled = !newValue
            isAccessibilityElement = !newValue
        }
    }
}
