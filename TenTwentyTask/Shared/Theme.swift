//
//  Theme.swift
//  QCSM4
//
//  Created by Yasir Basharat on 22/03/2019.
//  Copyright © 2019 Yasir Basharat. All rights reserved.
//

import UIKit

protocol Theme {
    
	func apply(for application: UIApplication)
}

extension Theme {

	func apply(for application: UIApplication) {

        UINavigationBar.appearance().with {
//            $0.barStyle = .black
            $0.tintColor = .white
            $0.barTintColor = .white

            
            $0.titleTextAttributes = [.foregroundColor: UIColor.white,
                                      .font: UIFont(defaultFontStyle: .bold, size: 19.0)]
                        
            $0.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.white,
                                      .font: UIFont(defaultFontStyle: .bold, size: 19.0)]
            
            $0.scrollEdgeAppearance?.titleTextAttributes = [.foregroundColor: UIColor.white,
                                                            .font: UIFont(defaultFontStyle: .bold, size: 19.0)]


            $0.largeTitleTextAttributes = [
                .foregroundColor: UIColor.white
            ]
        }
        

		UIView.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self])
            .backgroundColor = .black

		UILabel.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self])
            .textColor = .black
		//let temp = regularFont + 10.0


		// Ensure existing views render with new theme
		// https://developer.apple.com/documentation/uikit/uiappearance
        application.windows.reload()
	}

}
