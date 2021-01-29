//
//  CountryList.swift
//  INTITATests
//
//  Created by  Oleksii Kolomiiets on 27.01.2021.
//

import XCTest
@testable import INTITA

class CountryList: XCTestCase {

    func testGetCountry() {
        let geocode = "UA"
        
        XCTAssertEqual(geocode.localizedCountry(locale: Locale(identifier: "en_EN")), "Ukraine")
        XCTAssertEqual(geocode.localizedCountry(locale: Locale(identifier: "ua_UA")), "Україна")
        XCTAssertEqual(geocode.localizedCountry(locale: Locale(identifier: "ru_RU")), "Украина")
    }
}
