//
//  URLMockTest.swift
//  INTITATests
//
//  Created by Viacheslav Markov on 15.11.2020.
//

import XCTest
@testable import INTITA

class URLMockTest: XCTestCase {
    
    func testTrue() {
        
        let isJsonTrue = JSONLoader.loadJsonData(file: "token")
        XCTAssertNotNil(isJsonTrue)
    }
    
    func testNil() {
        
        let isJsonNil = JSONLoader.loadJsonData(file: "nil")
        XCTAssertNil(isJsonNil)
    }
    
    func testWrongNameFile() {
        
        let isWrongName = JSONLoader.loadJsonData(file: "Token")
        XCTAssertNil(isWrongName)
    }

}
