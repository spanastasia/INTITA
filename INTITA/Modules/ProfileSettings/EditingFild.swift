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
    
    func valueFromUser(_ user: EditingUser) -> String? {
        switch self {
        case .firstName: return user.firstName
        case .secondName: return user.secondName
        case .nickname: return user.nickname
        case .birthday: return user.birthday
        case .country: return user.country?.getLocalizedValue()
        case .city: return getCity(by: user.city)
        case .address: return user.address
        case .phone: return user.phone
        case .aboutMy: return user.aboutMy
        case .interests: return user.interests
        case .education: return user.education
        case .prev_job: return user.prevJob
        case .current_job: return user.currentJob
        case .aboutUs: return user.aboutUs
        case .skype: return user.skype
        case .facebook: return user.facebook
        case .linkedin: return user.linkedin
        case .twitter: return user.twitter
        case .prefer_specializations: return getPreferSpecializations(by: user.preferSpecializations)
        case .educform: return getEducform(by: user.educform)
        case .education_shift: return getEducationShift(by: user.educationShift)
        }
    }
    
    private func getCity(by id: Int?) -> String? {
        guard let countryId = id else { return nil }
        return JSONService<CityModel>.getValue(by: countryId)?.identifier.localized(locationType: .city)
    }
    
    private func getEducationShift(by id: Int?) -> String? {
        guard let educationShiftId = id else { return nil }
        return JSONService<EducationShiftModel>.getValue(by: educationShiftId)?.identifier.localized(locationType: .educationShift)
    }
    
    private func getEducform(by id: Int?) -> String? {
        guard let educform = id else { return nil }
        let e = EducationForm.init(rawValue: educform)
        return e?.description
    }
    
    private func getPreferSpecializations(by array: [Int]) -> String {
        var preferSpecializations: String = ""
        let koma = ", "

        for index in array {
            guard let specialization = JSONService<SpecializationModel>.getValue(by: index)?.identifier.localized(locationType: .specialization) else { return "" }
            preferSpecializations = index == array.last ? specialization : specialization + koma
        }
        
        return preferSpecializations
    }
}
