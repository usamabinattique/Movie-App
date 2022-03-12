//
//  Extension+NSManagedObject.swift
//  QCSM4
//
//  Created by Yasir Basharat on 08/03/2019.
//  Copyright © 2019 Yasir Basharat. All rights reserved.
//

import Foundation
import CoreData

public extension NSManagedObject {

	static var entiyName: String = {
		return String(describing: self)
	}()

	convenience init<T: NSManagedObject>(entity: T.Type, context: NSManagedObjectContext) {
		if #available(iOS 10.0, *) {
			self.init(context: context)
		} else {
			// Fallback on earlier versions
			let entity = NSEntityDescription.entity(forEntityName: T.entiyName, in: context)!
			self.init(entity: entity, insertInto: context)
		}
	}
}
