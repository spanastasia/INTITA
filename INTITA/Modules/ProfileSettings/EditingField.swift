//
//  EditingFild.swift
//  INTITA
//
//  Created by Viacheslav Markov on 30.01.2021.
//

import Foundation

enum EditingField: Int, CaseIterable {
    case firstName
    case secondName
    case nickname
    case birthday
    case country
    case city
    case address
    case phone
    case aboutMe
    case interests
    case education
    case previousJob
    case currentJob
    case aboutUs
    case skype
    case facebook
    case linkedin
    case twitter
    case preferedSpecializations
    case educform
    case educationShift
    
    var editType: SettingProfileCell {
        switch self {
        case .country, .city, .preferedSpecializations:
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
        case .aboutMe:
            return "about_me".localized
        case .interests:
            return "interests".localized
        case .education:
            return "education".localized
        case .previousJob:
            return "prev_job".localized
        case .currentJob:
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
        case .preferedSpecializations:
            return "prefer_specializations".localized
        case .educform:
            return "educ_form".localized
        case .educationShift:
            return "education_shift".localized
        }
    }
    
    static var statusList: [String] {
        return EditingField.allCases.map { $0.description }
    }
    
    func valueFromUser(_ user: EditingUser) -> String? {
        switch self {
        case .firstName: return user.firstName
        case .secondName: return user.secondName
        case .nickname: return user.nickname
        case .birthday: return user.birthday
        case .country: return user.country?.getLocalizedValue()
        case .city: return user.city?.getLocalizedValue()//getCity(by: user.city)
        case .address: return user.address
        case .phone: return user.phone
        case .aboutMe: return user.aboutMy
        case .interests: return user.interests
        case .education: return user.education
        case .previousJob: return user.prevJob
        case .currentJob: return user.currentJob
        case .aboutUs: return user.aboutUs
        case .skype: return user.skype
        case .facebook: return user.facebook
        case .linkedin: return user.linkedin
        case .twitter: return user.twitter
        case .preferedSpecializations: return getPreferSpecializations(by: user.preferSpecializations)
        case .educform: return getEducationForm(by: user.educform)
        case .educationShift: return getEducationShift(by: user.educationShift)
        }
    }
    
    private func getCity(by id: Int?) -> String? {
        guard let cityId = id else { return nil }
        
        return JSONService<CityModel>
            .getValue(by: cityId)?
            .identifier.localized(locationType: .city)
    }
    
    private func getEducationShift(by id: Int?) -> String? {
        guard let educationShiftId = id else { return nil }
        
        return JSONService<EducationShiftModel>
            .getValue(by: educationShiftId)?
            .identifier.localized(locationType: .educationShift)
    }
    
    private func getEducationForm(by id: Int?) -> String? {
        guard let id = id else { return nil }
        
        let form = EducationForm.init(rawValue: id)
        return form?.description
    }
    
    private func getPreferSpecializations(by array: [Int]) -> String {
        return array
            .map(mutateFromIdToSpec)
            .compactMap { $0 }
            .joined(separator: ", ")
    }
    
    func mutateFromIdToSpec(_ id: Int) -> String? {
        guard let specialization = JSONService<SpecializationModel>.getValue(by: id) else { return nil }
        
        return specialization.identifier.localized(locationType: .specialization)
    }
}
