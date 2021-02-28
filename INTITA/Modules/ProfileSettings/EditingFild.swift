//
//  EditingFild.swift
//  INTITA
//
//  Created by Viacheslav Markov on 30.01.2021.
//

import Foundation

enum EditingFild: Int, CaseIterable {
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
    case prev_job
    case current_job
    case aboutUs
    case skype
    case facebook
    case linkedin
    case twitter
    case prefer_specializations
    case educform
    case education_shift
    
    var editType: SettingProfileCell {
        switch self {
        case .country, .city, .prefer_specializations:
            return .button
        default:
            return .textField
        }
    }
    
    var description: String {
        switch self {
        case .firstName:
            return "first_name".localized
        case .secondName:
            return "second_name".localized
        case .nickname:
            return "nickname".localized
        case .birthday:
            return "birthday".localized
        case .country:
            return "country".localized
        case .city:
            return "city".localized
        case .address:
            return "address".localized
        case .phone:
            return "phone".localized
        case .aboutMy:
            return "about_me".localized
        case .interests:
            return "interests".localized
        case .education:
            return "education".localized
        case .prev_job:
            return "prev_job".localized
        case .current_job:
            return "current_job".localized
        case .aboutUs:
            return "about_us".localized
        case .skype:
            return "skype".localized
        case .facebook:
            return "facebook".localized
        case .linkedin:
            return "linkedin".localized
        case .twitter:
            return "twitter".localized
        case .prefer_specializations:
            return "prefer_specializations".localized
        case .educform:
            return "educ_form".localized
        case .education_shift:
            return "education_shift".localized
        }
    }
    
    static var statusList: [String] {
        return EditingFild.allCases.map { $0.description }
    }
    
    func valueFromUser(_ user: CurrentUser) -> String? {
        switch self {
        case .firstName: return user.firstName
        case .secondName: return user.secondName
        case .nickname: return user.nickname
        case .birthday: return user.birthday
        case .country: return "\(String(describing: user.country))"
        case .city: return "vin"
        case .address: return user.address
        case .phone: return user.phone
        case .aboutMy: return "user.about_me"
        case .interests: return "user.interests"
        case .education: return "user.education"
        case .prev_job: return "user.prev_job"
        case .current_job: return "user.current_job"
        case .aboutUs: return "user.about_us"
        case .skype: return "user.skype"
        case .facebook: return user.facebook
        case .linkedin: return user.linkedin
        case .twitter: return user.twitter
        case .prefer_specializations: return "user.preferSpecializations"
        case .educform: return "user.educ_form"
        case .education_shift: return "user.education_shift"
        }
    }
}
