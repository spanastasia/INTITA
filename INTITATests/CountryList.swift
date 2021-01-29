//
//  CountryList.swift
//  INTITATests
//
//  Created by  Oleksii Kolomiiets on 27.01.2021.
//

import XCTest
@testable import INTITA

class CountryList: XCTestCase {
    let countryList = CountryService()

    func testGetCountry() {
        guard let path = Bundle.main.path(forResource: "Countries", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
           let ukrainea = dict["1"] as? String
        else {
            XCTFail()
            return
        }
        guard let array = countryList.getCountries() else {
            XCTFail()
            return
        }
        var ukraine: CountryModel?
        array.map {
            if $0.geocode == "UA" {
                ukraine = $0
            }
        }

        
        XCTAssertEqual(ukraine?.geocode, "UA")
        XCTAssertEqual(ukraine?.titleEN, "Ukraine")
//        XCTAssertEqual(ukraine.localizedCountry(locale: Locale(identifier: "en_EN")), "Ukraine")
//        XCTAssertEqual(ukraine.localizedCountry(locale: Locale(identifier: "ua_UA")), "Україна")
//        XCTAssertEqual(ukraine.localizedCountry(locale: Locale(identifier: "ru_RU")), "Украина")
    }
}
