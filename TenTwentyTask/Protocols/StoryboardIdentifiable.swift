//
//  StoryboardIdentifiable.swift
//  QCSM4
//
//  Created by Usama Attique on 29/04/2019.
//  Copyright © 2019 Yasir Basharat. All rights reserved.
//

import UIKit

public protocol StoryboardIdentifiable {
	static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
	public static var storyboardIdentifier: String {
        String(describing: self)
	}
}

extension UIViewController: StoryboardIdentifiable { }
