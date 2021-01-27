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
        guard let path = Bundle.main.path(forResource: "Countries", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
           let ukraine = dict["1"] as? String
        else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(ukraine, "UA")
        XCTAssertEqual(ukraine.localizedCountry(locale: Locale(identifier: "en_EN")), "Ukraine")
        XCTAssertEqual(ukraine.localizedCountry(locale: Locale(identifier: "ua_UA")), "Україна")
        XCTAssertEqual(ukraine.localizedCountry(locale: Locale(identifier: "ru_RU")), "Украина")
    }
}
