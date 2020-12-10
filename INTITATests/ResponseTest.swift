//
//  ResponseTest.swift
//  INTITATests
//
//  Created by Viacheslav Markov on 17.11.2020.
//

import XCTest
@testable import INTITA

class ResponseTest: XCTestCase {
    
    override class func setUp() {
        APIRequest.httpType = .mock
    }

    func testTrue() {
        
        let apiRequestMock = APIRequest.shared
        XCTAssertTrue(apiRequestMock is MockRequestAPI)
    }

}
