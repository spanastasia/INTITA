//
//  CareerModel.swift
//  INTITA
//
//  Created by Viacheslav Markov on 11.03.2021.
//

import Foundation

struct CareerModel: LocalizedResponseProtocol {
    
    var id: Int
    var titleUA: String
    var titleRU: String
    var titleEN: String
    
    static var type: LocalizedFile { .career }
    
    enum CodingKeys: String, CodingKey {
        case id
        case titleUA = "title_ua"
        case titleRU = "title_ru"
        case titleEN = "title_en"
    }
}
