//
//  User+CoreDataProperties.swift
//  INTITA
//
//  Created by Svitlana Korostelova on 18.12.2020.
//
//

import Foundation
import CoreData


extension User {
    @NSManaged public var address: String?
    @NSManaged public var avatar: URL?
    @NSManaged public var birthday: String?
    @NSManaged public var email: String
    @NSManaged public var facebook: String?
    @NSManaged public var firstName: String
    @NSManaged public var fullName: String
    @NSManaged public var id: Int32
    @NSManaged public var linkedin: String?
    @NSManaged public var middleName: String?
    @NSManaged public var nickname: String?
    @NSManaged public var phone: String?
    @NSManaged public var preferSpecialization: String
    @NSManaged public var role: Int32
    @NSManaged public var secondName: String?
    @NSManaged public var twitter: String?

}

extension User : Identifiable {

}
