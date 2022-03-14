//
//  Router.swift
//  FleetDispatcher
//
//  Created by usama on 05/01/2021.
//

import UIKit

enum Router {
    
    static func search() -> SearchVC {
        UIStoryboard(storyboard: .main).instantiateViewController(withClass: SearchVC.self)!
    }
}
