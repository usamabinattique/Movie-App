//
//  UIWindow.swift
//  QCSM4
//
//  Created by Yasir Basharat on 22/03/2019.
//  Copyright © 2019 Yasir Basharat. All rights reserved.
//

import UIKit

public extension UIWindow {

    /// Unload all views and add back.
    /// Useful for applying `UIAppearance` changes to existing views.
    func reload() {
        subviews.forEach { view in
            view.removeFromSuperview()
            addSubview(view)
        }
    }

    func switchRootViewController(_ viewController: UIViewController,
								  animated: Bool = true,
								  duration: TimeInterval = 0.5,
								  options: UIView.AnimationOptions = .transitionCrossDissolve,
								  completion: (() -> Void)? = nil) {
        guard animated else {
            rootViewController = viewController
            return
        }

        UIView.transition(with: self, duration: duration, options: options, animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            self.rootViewController = viewController
            UIView.setAnimationsEnabled(oldState)
			// swiftlint:disable:next multiple_closures_with_trailing_closure
        }) { _ in
            completion?()
        }
    }
}

public extension Array where Element == UIWindow {

	/// Unload all views for each `UIWindow` and add back.
	/// Useful for applying `UIAppearance` changes to existing views.
	func reload() {
		forEach { $0.reload() }
	}
}
