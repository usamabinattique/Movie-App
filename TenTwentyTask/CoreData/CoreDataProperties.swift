//
//  CoreDataProperties.swift
//  QCSM4
//
//  Created by usama on 12/03/2022.
//  Copyright © 2019 Yasir Basharat. All rights reserved.
//

import Foundation
import CoreData

public struct DefaultFetchProperties {

	let includesSubentities: Bool
	var predicate: NSPredicate?
	let sortDescriptors: [NSSortDescriptor]?
	let limit: Int?

	init(includesSubentities: Bool = false,
		 predicate: NSPredicate? = nil,
		 sortDescriptors: [NSSortDescriptor]? = nil,
		 limit: Int? = nil) {

		self.includesSubentities = includesSubentities
		self.predicate = predicate
		self.sortDescriptors = sortDescriptors
		self.limit = limit
	}
}

public struct AsyncFetchProperties {

	let pageSize: Int
	var currentPage: Int
}

public struct ScalarFetchProperties {

	let returnsDistinctResults: Bool
	var resultType: NSFetchRequestResultType
	var shouldGroupProperties: Bool
	var propertiesToFetch: [Any]
}
