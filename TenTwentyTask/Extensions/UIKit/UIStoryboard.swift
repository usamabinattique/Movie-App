//
//  UIStoryboard.swift
//  QCSM4
//
//  Created by Yasir Basharat on 27/03/2019.
//  Copyright © 2019 Yasir Basharat. All rights reserved.
//

import UIKit

public extension UIStoryboard {

    enum Storyboard: String {

        case main

        var filename: String {
            rawValue.capitalized
        }
    }

    // MARK: - Convenience Initializers
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.filename, bundle: bundle)
    }

    // MARK: - Class Functions
    class func storyboard(_ storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        UIStoryboard(name: storyboard.filename, bundle: bundle)
    }

    /// Instantiate a UIViewController using its class name
    ///
    /// - Parameter name: UIViewController type
    /// - Returns: The view controller corresponding to specified class name
    func instantiateViewController<T: UIViewController>(withClass name: T.Type) -> T? {
        instantiateViewController(withIdentifier: String(describing: name)) as? T
    }

    func instantiateViewController<T>() -> T where T: StoryboardIdentifiable {

        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }

        return viewController
    }
}
