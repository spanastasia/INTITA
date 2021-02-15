//
//  SpecializationList.swift
//  INTITATests
//
//  Created by Viacheslav Markov on 15.02.2021.
//

import XCTest
@testable import INTITA

class SpecializationList: XCTestCase {
    
    func testGetSpecialization() {
        let idEn = "Programming"
        XCTAssertEqual(idEn.localized(locationType: .country, locale: Locale(identifier: "en_EN")), "Programming")
        
        let idUa = "Програмування"
        XCTAssertEqual(idUa.localized(locationType: .country, locale: Locale(identifier: "ua_UA")), "Програмування")
        let idRu = "Программирование"
        XCTAssertEqual(idRu.localized(locationType: .country, locale: Locale(identifier: "ru_RU")), "Программирование")
    }

}
