//
//  LogInViewModelTests.swift
//  INTITA
//
//  Created by Svitlana Korostelova on 24.11.2020.
//

import XCTest
@testable import INTITA

class LogInViewModelTests: XCTestCase {
    
    override class func setUp() {
        
    }
    
    func test_authorizationLoginDidCalled() {
        let expectation = self.expectation(description: "Authorization Login Failed on login")
        
        let authorizationMock = AuthorizationMock()
        authorizationMock.didCall_Login = {
            expectation.fulfill()
        }
        let sut = LogInViewModel(authorizationService: authorizationMock)
        sut.login(email: "mail", password: "password")

        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_authorizationFetchUserInfoDidCalled() {
    }
}
