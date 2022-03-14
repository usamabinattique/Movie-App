//
//  BaseVC.swift
//  TenTwentyTask
//
//  Created by usama on 12/03/2022.
//

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.theme
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            self.navigationController?.navigationBar.isTranslucent = true  // pass "true" for fixing iOS 15.0 black bg issue
            self.navigationController?.navigationBar.tintColor = UIColor.white // We need to set tintcolor for iOS 15.0
            appearance.shadowColor = .clear    //removing navigationbar 1 px bottom border.
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
        
    }

}
