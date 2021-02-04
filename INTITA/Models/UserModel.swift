//
//  UserModel.swift
//  INTITA
//
//  Created by Viacheslav Markov on 30.01.2021.
//

import Foundation

enum UserModel: Int, CaseIterable {
    case firstName
    case secondName
    case nickname
    case birthday
    case country  // values
    case city  // values
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
    case educform // values
    case education_shift  // values
    
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
        return UserModel.allCases.map { $0.description }
    }
}
