//
//  URLMockTest.swift
//  INTITATests
//
//  Created by Viacheslav Markov on 15.11.2020.
//

import XCTest
@testable import INTITA

class URLMockTest: XCTestCase {
    
    var sut = MockNetworking()
    
    func testTrue() {
        
        let isJsonTrue = sut.loadJsonData(file: "JSONTest")
            XCTAssertNotNil(isJsonTrue)

    }
    
    func testNil() {
        
        let isJsonNil = sut.loadJsonData(file: "nil")
        XCTAssertNil(isJsonNil, "your json is empty")
    }

}
