//
//  LogInViewModelTests.swift
//  INTITA
//
//  Created by Svitlana Korostelova on 24.11.2020.
//

import XCTest
@testable import INTITA

class LogInViewModelTests: XCTestCase {
    enum TestError: Error {
        case error
    }
    
    var authorizationMock: AuthorizationMock!
    var sut: LogInViewModel!
    let expectedEmail = "test.testovich@gmail.com"
    let expectedPassword = "somepassword"
    //TODO:        sut.delegate = self
    
    override func setUp() {
        super.setUp()
        authorizationMock = AuthorizationMock()
        sut = LogInViewModel(authorizationService: authorizationMock)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testInit() {
        XCTAssertNotNil(sut)
    }
    
    func test_subscribe() {
        // GIVEN:
        let expectation = self.expectation(description: "updateCallback was not set properly")
        let errorCallback: LogInViewModelCallback = { error in
            if error == nil {
                expectation.fulfill()
            }
        }
        // WHEN:
        sut.subscribe(updateCallback: errorCallback)
        sut.updateCallback?(nil)
        // THEN:
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_success_login() {
        // GIVEN:
        let expectation = self.expectation(description: "Authorization login success")
        // WHEN:
        sut.login(email: expectedEmail, password: expectedPassword)
        if authorizationMock.receivedEmail == expectedEmail && authorizationMock.receivedPassword == expectedPassword {
            expectation.fulfill()
        }
        // THEN:
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_failure_login() {
        // GIVEN:
        let expectation = self.expectation(description: "Authorization login failure")
        authorizationMock.error = TestError.error
        let errorCallback: LogInViewModelCallback = { error in
            if let error = error,
               case TestError.error = error {
                expectation.fulfill()
            }
        }
        // WHEN:
        sut.subscribe(updateCallback: errorCallback)
        sut.login(email: expectedEmail, password: expectedPassword)
        // THEN:
        waitForExpectations(timeout: 1, handler: nil)
    }
    
}
//TODO: Finish implimentation below
//extension LoginViewModelTests: LogInViewModelDelegate {
//    func loginSuccess() {
//        testExp?.fulfill()
//    }
//}

