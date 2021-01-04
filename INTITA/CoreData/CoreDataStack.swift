//
//  CoreDataStack.swift
//  INTITA
//
//  Created by Svitlana Korostelova on 18.12.2020.
//

import Foundation
import CoreData

final class CoreDataStack {
    private init(){}
    static let shared = CoreDataStack()
    private lazy var storeContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: AppConstans.coreDataModelName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    func saveContext () {
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
