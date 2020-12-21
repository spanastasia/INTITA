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
    
    static func retrieveDataFromDB(appUser: CurrentUser) -> User? {
        var currentUser: User?
        let request = User.fetchRequest()
        if let data = try? CoreDataStack.shared.managedContext.fetch(request) as? [User] {
            currentUser = data.filter ({ (user) in
                return user.id == appUser.id
            }).first
        }
        if let userDB = currentUser {
            return userDB
        }else{
            return nil
        }
    }
    
    static func saveDataToDB(appUser: CurrentUser) {
        let managedContext = CoreDataStack.shared.managedContext
        
        let userDB: User
        if let alreadyExistUser = retrieveDataFromDB(appUser: appUser) {
            userDB = alreadyExistUser
        }else{
            userDB = User(context: managedContext)
            userDB.id = Int32(appUser.id)
        }
        userDB.firstName = appUser.firstName
        userDB.secondName = appUser.secondName
        userDB.fullName = appUser.fullName
        userDB.middleName = appUser.middleName
        userDB.nickname = appUser.nickname
        userDB.birthday = appUser.birthday
        userDB.email = appUser.email
        userDB.facebook = appUser.facebook
        userDB.linkedin = appUser.linkedin
        userDB.twitter = appUser.twitter
        userDB.phone = appUser.phone
        userDB.address = appUser.address
        userDB.avatar = appUser.avatar
        userDB.role = Int32(appUser.role)
        userDB.preferSpecialization = appUser.preferSpecializations.first?.specialization.title ?? ""
        CoreDataStack.shared.saveContext()
    }
}
