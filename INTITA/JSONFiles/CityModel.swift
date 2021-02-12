//
//  CityModel.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 12.02.2021.
//

import Foundation

struct CityModel: BaseProtocol {
    var id: Int
    var countryId: Int
    var titleUA: String
    var titleRU: String
    var titleEN: String

    var identifier: String { String(id) }
    
    enum CodingKeys: String, CodingKey {
        case id
        case countryId = "country"
        case titleUA = "title_ua"
        case titleRU = "title_ru"
        case titleEN = "title_en"
    }
}
