//
//  ApperanceProxyManager.swift
//  QCSM4
//
//  Created by Yasir Basharat on 12/03/2019.
//  Copyright © 2019 Yasir Basharat. All rights reserved.
//

import UIKit


class AppearanceProxyManager {

	static let shared = AppearanceProxyManager()
	private let theme: Theme = DefaultTheme()

	var currentTheme: Theme {
        theme
	}


	///
    func applyDefaultControllsApperance() {
        
        theme.apply(for: UIApplication.shared)
//        if #available(iOS 15, *) {
//            let appearance = UINavigationBarAppearance()
//            appearance.configureWithOpaqueBackground()
//            appearance.shadowColor = .yellow
//            UINavigationBar.appearance().standardAppearance = appearance
//            UINavigationBar.appearance().scrollEdgeAppearance = appearance
//        }
    }
}
