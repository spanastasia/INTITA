//
//  EditingUser.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 15.02.2021.
//

import Foundation

struct EditingUser: Codable {
    var firstName: String?
    var secondName: String?
    var nickname: String?
    var birthday: String?
    var country: CountryModel?
    var city: CityModel?
    var address: String?
    var phone: String?
    var aboutMy: String?
    var interests: String?
    var education: String?
    var prevJob: String?
    var currentJob: String?
    var aboutUs: String?
    var skype: String?
    var facebook: String?
    var linkedin: String?
    var twitter: String?
    var preferSpecializations: [Int]
    var educform: Int?
    var educationShift: Int?
    
    enum CodingKeys: String, CodingKey {
        case firstName
        case secondName
        case nickname
        case birthday
        case country
        case city
        case address
        case phone
        case aboutMy
        case interests
        case education
        case prevJob = "prev_job"
        case currentJob = "current_job"
        case aboutUs
        case skype
        case facebook
        case linkedin
        case twitter
        case preferSpecializations = "prefer_specializations"
        case educform
        case educationShift = "education_shift"
    }
}

extension EditingUser {
    init(from existingUser: CurrentUser) {
        firstName = existingUser.firstName
        secondName = existingUser.secondName
        nickname = existingUser.nickname
        birthday = existingUser.birthday
        country = JSONService<CountryModel>.getValue(by: existingUser.country)
        city = JSONService<CityModel>.getValue(by: existingUser.city)
        address = existingUser.address
        phone = existingUser.phone
        aboutMy = existingUser.aboutMy
        interests = existingUser.interests
        education = existingUser.education
        prevJob = existingUser.prevJob
        currentJob = existingUser.currentJob
        aboutUs = existingUser.aboutUs
        skype = existingUser.skype
        facebook = existingUser.facebook
        linkedin = existingUser.linkedin
        twitter = existingUser.twitter
        preferSpecializations = existingUser.preferSpecializations.map(\.specializationId)
        educform = existingUser.educform
        educationShift = existingUser.educationShift
    }
}
