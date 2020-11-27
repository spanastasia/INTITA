//
//  LogInViewModelTests.swift
//  INTITA
//
//  Created by Svitlana Korostelova on 24.11.2020.
//

import XCTest
@testable import INTITA

class LogInViewModelTests: XCTestCase {
    var authorizationMock: AuthorizationMock!
    var sut: LogInViewModel!
    
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
        let myCallback: LogInViewModelCallback = { error in
            if error == nil {
                expectation.fulfill()
            }
        }
        //        sut.delegate = self
        //        sut.subscribe { error in
        //            testError = error
        //
        //            exp.fulfill()
        //        }
        
        // WHEN:
        sut.subscribe(updateCallback: myCallback)
        sut.updateCallback?(nil)
        
        waitForExpectations(timeout: 1, handler: nil)
        //        // THEN:
        //        waitForExpectations(timeout: 3.0) { error in
        //            XCTAssertNil(error)
        //            XCTAssertNil(testError)
        //        }
    }
    
        func test_login() {
            let expectation = self.expectation(description: "Authorization Login Failed on login")
            // GIVEN:
            let expectedEmail = "some-email"
            let expectedPassword = "some-password"

//            authorizationMock.didCall_Login = { email, password in
//                if email == expectedEmail && password == expectedPassword {
//                    expectation.fulfill()
//                }
//            }
            // WHEN:
            sut.login(email: expectedEmail, password: expectedPassword)
            
            if authorizationMock.receivedEmail == expectedEmail && authorizationMock.receivedPassword == expectedPassword {
                expectation.fulfill()
            }

            let anotherExpectation = self.expectation(description: "...")
            if authorizationMock.error == nil {
                //            authorizationMock.login(email: expectedEmail, password: expectedPassword, completion: <#T##(Error?) -> Void#>)
                //
//                authorizationMock.fetchUserInfo(completion: (nil->())?)
                anotherExpectation.fulfill()
            }
            waitForExpectations(timeout: 1, handler: nil)
        }
    
  
}

//extension LoginViewModelTests: LogInViewModelDelegate {
//    func loginSuccess() {
//        testExp?.fulfill()
//    }
//}

