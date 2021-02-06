//
//  EducationForm.swift
//  INTITA
//
//  Created by Svitlana Korostelova on 06.02.2021.
//

import Foundation

enum EducationForm: Int, Codable {
    case online = 1
    case offline
    case onlineOffline
    
    var description: String {
        switch self {
        case .online:
            return "online".localized
        case .offline:
            return "offline".localized
        case .onlineOffline:
            return "online_offline".localized
        }
    }
}

enum CodingKeys: String, CodingKey {
    case id
    case titleUA = "title_ua"
    case titleRU = "title_ru"
    case titleEN = "title_en"
}

