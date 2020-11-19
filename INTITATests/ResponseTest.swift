//
//  ResponseTest.swift
//  INTITATests
//
//  Created by Viacheslav Markov on 17.11.2020.
//

import XCTest
@testable import INTITA

class ResponseTest: XCTestCase {

    var sut = APIRequest()

    func testTrue() {
        
        sut.httpType = .mock
        
        let isTrue = sut.shared
//        print(isTrue)
        XCTAssertNotNil(isTrue)

    }
    
    func testFalse() {

    }
}
