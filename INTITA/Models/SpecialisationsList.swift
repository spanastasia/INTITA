//
//  SpecialisationsList.swift
//  INTITA
//
//  Created by Viacheslav Markov on 11.02.2021.
//

import Foundation

enum SpecialisationsList: Int {
    case programming = 1
    case web_design
    case manual_qa
    case dev_ops
    case system_administration
    case hosting_support
    case english_for_it
    case hackers_school
    case it_camp
    case hr_and_ta
    case project_management
    case automation_qa
    
    var description: String {
        switch self {
        case .programming:
            return "programming".localized
        case .web_design:
            return "web_design".localized
        case .manual_qa:
            return "manual_qa".localized
        case .dev_ops:
            return "dev_ops".localized
        case .system_administration:
            return "system_administration".localized
        case .hosting_support:
            return "hosting_support".localized
        case .english_for_it:
            return "english_for_it".localized
        case .hackers_school:
            return "hackers_school".localized
        case .it_camp:
            return "it_camp".localized
        case .hr_and_ta:
            return "hr_and_ta".localized
        case .project_management:
            return "project_management".localized
        case .automation_qa:
            return "automation_qa".localized
        }
    }
    
}

enum CodingKeyEducation: String, CodingKey {
    case id
    case titleUA = "title_ua"
    case titleRU = "title_ru"
    case titleEN = "title_en"
    case createdAt = "created_at"
    case updatedAt = "updated_at"
    case title = "title"
}
