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
        let geocodeUA = "UA"
        XCTAssertEqual(geocodeUA.localizedCountry(locale: Locale(identifier: "en_EN")), "Ukraine")
        XCTAssertEqual(geocodeUA.localizedCountry(locale: Locale(identifier: "ua_UA")), "Україна")
        XCTAssertEqual(geocodeUA.localizedCountry(locale: Locale(identifier: "ru_RU")), "Украина")
        
        let geocodeRU = "RU"
        XCTAssertEqual(geocodeRU.localizedCountry(locale: Locale(identifier: "en_EN")), "Russia")
        XCTAssertEqual(geocodeRU.localizedCountry(locale: Locale(identifier: "ua_UA")), "Росія")
        XCTAssertEqual(geocodeRU.localizedCountry(locale: Locale(identifier: "ru_RU")), "Россия")
        
        let geocodeGB = "GB"
        XCTAssertEqual(geocodeGB.localizedCountry(locale: Locale(identifier: "en_EN")), "United Kingdom")
        XCTAssertEqual(geocodeGB.localizedCountry(locale: Locale(identifier: "ua_UA")), "Велика Британія")
        XCTAssertEqual(geocodeGB.localizedCountry(locale: Locale(identifier: "ru_RU")), "Великобритания")
        
        let geocodeBY = "BY"
        XCTAssertEqual(geocodeBY.localizedCountry(locale: Locale(identifier: "en_EN")), "Belarus")
        XCTAssertEqual(geocodeBY.localizedCountry(locale: Locale(identifier: "ua_UA")), "Білорусь")
        XCTAssertEqual(geocodeBY.localizedCountry(locale: Locale(identifier: "ru_RU")), "Беларусь")
    }
}
