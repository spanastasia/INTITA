//
//  EducationShiftModel.swift
//  INTITA
//
//  Created by Viacheslav Markov on 04.03.2021.
//

import Foundation

struct EducationShiftModel: LocalizedResponseProtocol {
    
    var id: Int
    var titleUA: String
    var titleRU: String
    var titleEN: String
    
    static var type: LocationType {
        return .educationShift
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case titleUA = "title_ua"
        case titleRU = "title_ru"
        case titleEN = "title_en"
    }
}
