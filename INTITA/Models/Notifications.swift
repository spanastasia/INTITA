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
    //var readDate: String?
    //var receiverDeleteDate: Int?
    var parentId: Int?
    //var senderDeleteDate: String?
    var createdAt: String?
    var updatedAt: String?
    var organizationId: Int?
    
    var userReceiver: resiver
//    var user_sender: sender
//    var organization: organization
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        type = try container.decode(Int.self, forKey: .type)
        createDate = try container.decode(String.self, forKey: .createDate)
        sender = try container.decode(Int.self, forKey: .sender)
        receiver = try container.decode(Int.self, forKey: .receiver)
        subject = try container.decode(String.self, forKey: .subject)
        messageText = try container.decode(String.self, forKey: .messageText)
        //readDate = try container.decode(String.self, forKey: .readDate)
        //receiverDeleteDate = try container.decode(Int.self, forKey: .receiverDeleteDate)
        parentId = try container.decode(Int.self, forKey: .parentId)
        //senderDeleteDate = try container.decode(String.self, forKey: .senderDeleteDate)
        createdAt = try container.decode(String.self, forKey: .createdAt)
        updatedAt = try container.decode(String.self, forKey: .updatedAt)
        organizationId = try container.decode(Int.self, forKey: .organizationId)
        
        userReceiver = try container.decode(resiver.self, forKey: .userReceiver)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case createDate = "create_date"
        case sender
        case receiver
        case subject
        case messageText = "message_text"
        //case readDate = "read_date"
        //case receiverDeleteDate = "receiver_delete_date"
        case parentId = "parent_id"
        //case senderDeleteDate = "sender_delete_date"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case organizationId = "organization_id"
        case userReceiver = "user_receiver"
    }
    
    
}



struct resiver: Codable{
//    var   id: Int?
//    var   firstName: String?
//    var   full_name: String?
//    var   middleName: String?
//    var   secondName: String?
//    var   nickname: String?
//    var   birthday: String?
    var   email: String?
//    var   corporate_mail: String?
//    var   facebook: String?
//    var   googleplus: String?
//    var   linkedin: String?
//    var   twitter: String?
//    var   phone: String?
//    var   address: String?
//    var   education: String?
//    var   educform: String?
//    var   interests: String?
//    var   aboutUs: String?
//    var   aboutMy: String?
//    var   avatar: String?
//    var   role: Int?
//    var   reg_time: String?
//    var   skype: String?
//    var   country: String?
//    var   city: String?
//    var   prev_job: String?
//    var   current_job: String?
//    var   education_shift: String?
//    var   title: String?
//    var   shortTitle: String?
//    var   userStatus: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        email = try container.decode(String.self, forKey: .email)
        
    }
    
    enum CodingKeys: String, CodingKey {
        case email
        
    }
    
}

struct sender: Codable  {
    var id: Int?
    var firstName: String?
    var full_name: String?
    var middleName: String?
    var secondName: String?
    var nickname: String?
    var birthday: String?
    var email: String?
    var corporate_mail: String?
    var facebook: String?
    var googleplus: String?
    var linkedin: String?
    var twitter: String?
    var phone: String?
    var address: String?
    var education: String?
    var educform: String?
    var interests: String?
    var aboutUs: String?
    var aboutMy: String?
    var avatar: String?
    var role: String?
    var reg_time: String?
    var skype: String?
    var country: String?
    var city: String?
    var prev_job: String?
    var current_job: String?
    var education_shift: String?
    var title: String?
    var shortTitle: String?
    var userStatus: String?
    }

struct organization: Codable {
    var id: Int?
    var name: String?
    var email: String?
    var phone: String?
    var url: String?
    var coefficient_offline: Double?
    var coefficient_online: Double?
    var coefficient_module_in_course: Double?
    var facebook: String?
    var linkedin: String?
    var twitter: String?
    var logo: URL?
    // "Xz3fpI7s8nT6ScZdcAE3Q1kTfD2KAI.png"
    var created_at: String?
    var updated_at: String?
    }

