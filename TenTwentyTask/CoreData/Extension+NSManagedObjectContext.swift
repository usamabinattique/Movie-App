//
//  Extension+NSManagedObjectContext.swift
//  QCSM4
//
//  Created by usama on 12/03/2022.
//  Copyright © 2019 Yasir Basharat. All rights reserved.
//

import Foundation
import CoreData

public extension NSManagedObjectContext {

	final func newBackgroundContext(asChildContext isChildContext: Bool = false) -> NSManagedObjectContext {
		let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)

		if isChildContext {
			context.parent = self
		} else {
			context.persistentStoreCoordinator = persistentStoreCoordinator
		}

		return context
	}

	/// <#Description#>
	///
	/// - Returns: return value description
	func saveOrRollback() -> Bool {
		do {
			try save()
			return true
		} catch {
			rollback()
			return false
		}
	}

	/// <#Description#>
	///
	/// - Parameter block: <#block description#>
	func performChanges(block: @escaping () -> Void) {
		perform { // Performing block inside our managed object context queue preserving thread logic
			block()
			_ = self.saveOrRollback()
		}
	}
}
/// Create Entity Object With Fallback
public extension NSManagedObjectContext {

	func createEntity<T: NSManagedObject>(entity: T.Type) -> T {

		if #available(iOS 10.0, *) {
			return T(context: self)
		} else {
			// Fallback on earlier versions
			let entity = NSEntityDescription.entity(forEntityName: String(describing: T.self), in: self)!
			return T(entity: entity, insertInto: self)
		}
	}
}
public extension NSManagedObjectContext {

	/// <#Description#>
	///
	/// - Parameter defaultFetchProperties: <#defaultFetchProperties description#>
	/// - Returns: <#return value description#>
	func fetch<T: NSManagedObject>(entity: T.Type, defaultFetchProperties: DefaultFetchProperties) throws -> [T] {

		let fetchRequest: NSFetchRequest<T> = createfetchRequest(entity: entity,
																 defaultFetchProperties: defaultFetchProperties)
		do {
			return try fetch(fetchRequest)
		} catch {
			throw error
		}
	}

//	public func fetch<T: NSManagedObject, U>(entity: T.Type, destinationEntity: U.Type, defaultFetchProperties: DefaultFetchProperties)throws -> [U] {
//
//		let fetchRequest: NSFetchRequest<T> = createfetchRequest(entity: entity,
//																 defaultFetchProperties: defaultFetchProperties,
//																 asyncFetchProperties: nil,
//																 scalarFetchProperties: nil)
//		do {
//			let fetchedResult = try fetch(fetchRequest)
//
//			return fetchedResult.compactMap {
//				print($0)
//				return $0.toEntity() as? U
//			}
//		} catch {
//			throw error
//		}
//	}

	func fetch<T: NSManagedObject>(entity: T.Type,
								   defaultFetchProperties: DefaultFetchProperties,
								   scalar: ScalarFetchProperties) throws -> [[String: Any]] {

		let fetchRequest: NSFetchRequest<NSFetchRequestResult> = createfetchRequest(entity: entity,
																 defaultFetchProperties: defaultFetchProperties,
																 scalarFetchProperties: scalar) as! NSFetchRequest<NSFetchRequestResult>
        if let result = try? fetch(fetchRequest) as? [[String: Any]], result.count > 0 {
			return result
		}
		return [[:]]
	}

	func fetch<T>(entity: T.Type, asyncFetchProperties: AsyncFetchProperties,
						 defaultFetchProperties: DefaultFetchProperties,
						 completion: @escaping (_ result: [T]) -> Void) throws where T: NSManagedObject {

		let fetchRequest: NSFetchRequest<T> = createfetchRequest(entity: entity,
																 defaultFetchProperties: defaultFetchProperties,
																 asyncFetchProperties: asyncFetchProperties)

		let asyncfetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { (result) in

			completion(result.finalResult ?? [])
		}

		do {
			try execute(asyncfetchRequest)
		} catch {
			throw error
		}
	}
	/// <#Description#>
	///
	/// - Parameter defaultFetchProperties: <#defaultFetchProperties description#>
	/// - Returns: <#return value description#>
	func firstOrDefault<T>(entity: T.Type, defaultFetchProperties: DefaultFetchProperties)
		throws -> T? where T: NSManagedObject {

			let fetchRequest: NSFetchRequest<T> = createfetchRequest(entity: entity,
																	 defaultFetchProperties: defaultFetchProperties)
			fetchRequest.fetchLimit = 1
			do {
				return try fetch(fetchRequest).first

			} catch {
				throw error
			}
        }
	private func createfetchRequest<T>(entity: T.Type, defaultFetchProperties: DefaultFetchProperties,
									   asyncFetchProperties: AsyncFetchProperties? = nil,
									   scalarFetchProperties: ScalarFetchProperties? = nil)
		-> NSFetchRequest<T> where T: NSManagedObject {

			let fetchRequest = NSFetchRequest<T>(entityName: String(describing: T.self))
			fetchRequest.includesSubentities = defaultFetchProperties.includesSubentities

			if let predicate = defaultFetchProperties.predicate {
				fetchRequest.predicate = predicate
			}

			if let sortDescriptors = defaultFetchProperties.sortDescriptors {
				fetchRequest.sortDescriptors = sortDescriptors
			}

			if let limit = defaultFetchProperties.limit {
				fetchRequest.fetchLimit = limit
			}

			if let asyncFetchProperties = asyncFetchProperties {
				fetchRequest.fetchOffset = asyncFetchProperties.pageSize * asyncFetchProperties.currentPage
				fetchRequest.fetchLimit = asyncFetchProperties.pageSize
				fetchRequest.fetchBatchSize = asyncFetchProperties.pageSize
			}

			if let scalarFetchProperties = scalarFetchProperties {
				fetchRequest.returnsDistinctResults = scalarFetchProperties.returnsDistinctResults
				fetchRequest.resultType = scalarFetchProperties.resultType
				fetchRequest.propertiesToFetch = scalarFetchProperties.propertiesToFetch
				if scalarFetchProperties.shouldGroupProperties {
					fetchRequest.propertiesToGroupBy = scalarFetchProperties.propertiesToFetch
				}
			}

			return fetchRequest
	}

	func countAll<T: NSManagedObject>(entity: T.Type) throws -> Int {

		let request = NSFetchRequest<T>(entityName: String(describing: T.self))
		return try count(for: request)
	}
}

