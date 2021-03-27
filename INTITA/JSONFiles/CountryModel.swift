//
//  CountryModel.swift
//  INTITA
//
//  Created by Stepan Niemykin on 29.01.2021.
//

import UIKit

struct CountryModel: LocalizedResponseProtocol, Equatable {
    var id: Int
    var titleUA: String
    var titleRU: String
    var titleEN: String
    var geocode: String
    
    var identifier: String { geocode }
    static var type: LocalizedFile { .country }
    
    var icon: UIImage? {
        return flag(country: geocode)
            .emojiToImage()
    }

    enum CodingKeys: String, CodingKey {
        case id
        case titleUA = "title_ua"
        case titleRU = "title_ru"
        case titleEN = "title_en"
        case geocode
    }
    
    func flag(country: String) -> String {
        let base = 127397
        var usv = String.UnicodeScalarView()
        for i in country.utf16 {
            usv.append((UnicodeScalar(base + Int(i)) ?? UnicodeScalar.init(0)))
        }
        return String(usv)
    }

}

