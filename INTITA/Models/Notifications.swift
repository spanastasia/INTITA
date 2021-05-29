//
//  Notifications.swift
//  INTITA
//
//  Created by Yevhenii Manilko on 16.05.2021.
//

import Foundation

struct Notifikation: Codable {
    
    var rows: [Messeg]
    var count: Int
    var notificationsAmount: Int

    enum CodingKeys: String, CodingKey {
        case count
        case notificationsAmount
        case rows
    }

}

struct Messeg: Codable {
    
    var id : Int?
    var type: Int?
    var createDate: String?
    var sender: Int?
    var receiver: Int?
    var subject: String?
    var messageText: String?
    var parentId: Int?
    var createdAt: String?
    var updatedAt: String?
    var organizationId: Int?
    
    var userReceiver: resiver
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case createDate = "create_date"
        case sender
        case receiver
        case subject
        case messageText = "message_text"
        case parentId = "parent_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case organizationId = "organization_id"
        case userReceiver = "user_receiver"
    }
    
    
}



struct resiver: Codable{
    var   email: String?

    enum CodingKeys: String, CodingKey {
        case email
        
    }
    
}

