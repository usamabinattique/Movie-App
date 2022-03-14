//
//  NSObject.swift
//  QCSM4
//
//  Created by Yasir Basharat on 22/03/2019.
//  Copyright © 2019 Yasir Basharat. All rights reserved.
//

import Foundation

public protocol With {}

public extension With where Self: Any {

	/// Makes it available to set properties with closures just after initializing.
	///
	///     let label = UILabel().with {
	///       $0.textAlignment = .center
	///       $0.textColor = UIColor.black
	///       $0.text = "Hello, World!"
	///     }
	@discardableResult
	func with(_ block: (Self) -> Void) -> Self {
		block(self)
		return self
	}
}

extension NSObject: With {}

