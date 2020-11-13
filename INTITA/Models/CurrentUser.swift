//
//  CurrentUser.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 10.11.2020.
//

import Foundation

// MARK:- CurrentUser
struct CurrentUser: Codable {
    var id: Int
    var firstName, fullName: String
    var middleName: String?
    var secondName: String
    var nickname: String?
    var birthday, email: String
    var facebook, linkedin: String?
    var twitter, phone, address: String?
    var avatar: URL?
    var role: Int
    
    var preferSpecializations: [PreferSpecialization]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        firstName = try container.decode(String.self, forKey: .firstName)
        fullName = try container.decode(String.self, forKey: .fullName)
        middleName = try container.decodeIfPresent(String.self, forKey: .middleName)
        secondName = try container.decode(String.self, forKey: .secondName)
        nickname = try container.decodeIfPresent(String.self, forKey: .nickname)
        birthday = try container.decode(String.self, forKey: .birthday)
        email = try container.decode(String.self, forKey: .email)
        facebook = try container.decodeIfPresent(String.self, forKey: .facebook)
        linkedin = try container.decodeIfPresent(String.self, forKey: .linkedin)
        twitter = try container.decodeIfPresent(String.self, forKey: .twitter)
        phone = try container.decodeIfPresent(String.self, forKey: .phone)
        address = try container.decodeIfPresent(String.self, forKey: .address)
        if let avatarString = try container.decodeIfPresent(String.self, forKey: .avatar) {
            avatar = URL(string: avatarString)
        } else {
            avatar = nil
        }
        role = try container.decode(Int.self, forKey: .role)
        preferSpecializations = try container.decode([PreferSpecialization].self, forKey: .preferSpecializations)
    }

    enum CodingKeys: String, CodingKey {
        case id, firstName
        case fullName = "full_name"
        case middleName, secondName, nickname, birthday, email
        case facebook, linkedin, twitter, phone, address, avatar, role
        case preferSpecializations = "prefer_specializations"
    }
}

// MARK:- PreferSpecialization
struct PreferSpecialization: Codable {
    let userId, specializationId: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case userId = "id_user"
        case specializationId = "id_specialization"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

