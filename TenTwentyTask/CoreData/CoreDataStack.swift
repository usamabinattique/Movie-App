//
//  CoreDataStack.swift
//  QCSM4
//
//  Created by usama on 12/03/2022.
//

import Foundation
import CoreData

class CoreDataStack {

	let persistentContainer: NSPersistentContainer
	lazy var mainContext = persistentContainer.viewContext

	init(modelName: String) {
		guard let modelURL = Bundle(for: type(of: self))
			.url(forResource: modelName, withExtension: "momd") else {
				fatalError("Error loading model from bundle")
		}
		guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
			fatalError("Error initializing mom from: \(modelURL)")
		}
		let container = NSPersistentContainer(name: modelName, managedObjectModel: mom)
		container.loadPersistentStores { descriptions, error in
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo) \(descriptions)")
			}
			container.viewContext.automaticallyMergesChangesFromParent = true
			//container.viewContext.inferMappingAutomatically = true
		}
		persistentContainer = container
	}
}
