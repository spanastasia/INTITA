//
//  CountryModel.swift
//  INTITA
//
//  Created by Stepan Niemykin on 29.01.2021.
//

import Foundation

struct CountryModel: Codable {
    var id: Int
    var titleUA: String
    var titleRU: String
    var titleEN: String
    var geocode: String

    enum CodingKeys: String, CodingKey {
        case id
        case titleUA = "title_ua"
        case titleRU = "title_ru"
        case titleEN = "title_en"
        case geocode
    }
}

