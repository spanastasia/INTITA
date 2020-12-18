//
//  CoreDataService.swift
//  INTITA
//
//  Created by Svitlana Korostelova on 18.12.2020.
//

import UIKit
import CoreData

class CoreDataService {
    private init() {}
    private static var user: NSManagedObject?
    static func saveDataToDB(appUser: CurrentUser){
        DispatchQueue.main.async {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            
            let managedContext = appDelegate.persistentContainer.viewContext
        
            let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
            
            let userDB = NSManagedObject(entity: entity, insertInto: managedContext)

            userDB.setValue(appUser.firstName, forKeyPath: "firstName")
            // list all values from struct instance
            
            do {
                try managedContext.save()
                CoreDataService.user = userDB
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    static func retrieveDataFromDB(){
        //
    }
}
