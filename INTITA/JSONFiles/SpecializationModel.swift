//
//  SpecializationModel.swift
//  INTITA
//
//  Created by Viacheslav Markov on 15.02.2021.
//

import Foundation

struct SpecializationModel: LocalizedResponseProtocol {
    
    var id: Int
    var titleUA: String
    var titleRU: String
    var titleEN: String
    
    static var type: LocalizedFile { .specialization }
    
    enum CodingKeys: String, CodingKey {
        case id
        case titleUA = "title_ua"
        case titleRU = "title_ru"
        case titleEN = "title_en"
    }
}
