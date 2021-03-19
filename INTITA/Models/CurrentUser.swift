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
    var secondName: String?
    var nickname: String?
    var birthday: String?
    var email: String
    var facebook, linkedin: String?
    var twitter, phone, address: String?
    var avatar: URL?
    var role: Int
    var country: Int?
    var city: Int?
    var educationShift: Int?
    var aboutMy: String?
    var interests: String?
    var education: String?
    var prevJob: String?
    var currentJob: String?
    var aboutUs: String?
    var skype: String?
    var educform: Int?
    
    var preferSpecializations: [PreferSpecialization]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        firstName = try container.decode(String.self, forKey: .firstName)
        fullName = try container.decode(String.self, forKey: .fullName)
        middleName = try container.decodeIfPresent(String.self, forKey: .middleName)
        secondName = try container.decodeIfPresent(String.self, forKey: .secondName)
        nickname = try container.decodeIfPresent(String.self, forKey: .nickname)
        birthday = try container.decodeIfPresent(String.self, forKey: .birthday)
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
        country = try container.decodeIfPresent(Int.self, forKey: .country)
        city = try container.decodeIfPresent(Int.self, forKey: .city)
        educationShift = try container.decodeIfPresent(Int.self, forKey: .educationShift)
        aboutMy = try container.decodeIfPresent(String.self, forKey: .aboutMy)
        interests = try container.decodeIfPresent(String.self, forKey: .interests)
        education = try container.decodeIfPresent(String.self, forKey: .education)
        prevJob = try container.decodeIfPresent(String.self, forKey: .prevJob)
        currentJob = try container.decodeIfPresent(String.self, forKey: .currentJob)
        aboutUs = try container.decodeIfPresent(String.self, forKey: .aboutUs)
        skype = try container.decodeIfPresent(String.self, forKey: .skype)
        educform = try container.decodeIfPresent(Int.self, forKey: .educform)
    }
    
    init?(from editingUser: EditingUser) {
        guard let current = UserData.currentUser else { return nil }
        
        id = current.id
        firstName = editingUser.firstName ?? current.firstName
        secondName = editingUser.secondName ?? current.secondName
        middleName = current.middleName
        var str = ""
        if firstName.count > 0 {
            str.append(firstName)
            if secondName != nil {
                str.append(" ")
            }
            if let surname = secondName {
                str.append(surname)
            }
        }
        
        fullName = str
        nickname = editingUser.nickname
        birthday = editingUser.birthday
        email = current.email
        facebook = editingUser.facebook
        linkedin = editingUser.linkedin
        twitter = editingUser.twitter
        phone = editingUser.phone
        address = editingUser.address
        avatar = current.avatar
        role = current.role
        
        //TODO: preferedSpecializations in CurrentuUser and in EditingUser are of different types.
        preferSpecializations = current.preferSpecializations
        country = editingUser.country?.id
        city = editingUser.city?.id
        educationShift = editingUser.educationShift
        aboutMy = editingUser.aboutMy
        interests = editingUser.interests
        education = editingUser.education
        prevJob = editingUser.prevJob
        currentJob = editingUser.currentJob
        aboutUs = editingUser.aboutUs
        skype = editingUser.skype
        educform = editingUser.educform
    }

    enum CodingKeys: String, CodingKey {
        case id, firstName
        case fullName = "full_name"
        case middleName, secondName, nickname, birthday, email
        case facebook, linkedin, twitter, phone, address, avatar, role
        case preferSpecializations = "prefer_specializations"
        case country
        case educationShift = "education_shift"
        case city
        case aboutMy = "about_my"
        case interests
        case education
        case prevJob = "prev_job"
        case currentJob = "current_job"
        case aboutUs = "about_us"
        case skype
        case educform = "educ_form"
    }
}

// MARK:- PreferSpecialization
struct PreferSpecialization: Codable {
    let specializationId: Int
    let specialization: Specialization

    enum CodingKeys: String, CodingKey {
        case specializationId = "id_specialization"
        case specialization
    }
}

struct Specialization: Codable {
    let id: Int
    private let titleUa, titleEn, titleRu: String
    
    public var title: String? {
        switch Locale.current.languageCode {
        case "en":
            return titleEn
        case "ru":
            return titleRu
        default:
            return titleUa
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case titleUa = "title_ua"
        case titleEn = "title_en"
        case titleRu = "title_ru"
    }
}
