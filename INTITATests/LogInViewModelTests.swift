//
//  LogInViewModelTests.swift
//  INTITA
//
//  Created by Svitlana Korostelova on 24.11.2020.
//

import XCTest
@testable import INTITA

extension LogInViewModel {
    convenience init(authorizationService: AuthorizationProtocol) {
        self.init()
        self.authorizationService = authorizationService
    }
}

class MockLogInViewModelDelegate: LogInViewModelDelegate {
    private var expectation: XCTestExpectation?
    private var testCase: XCTestCase
    
    init(testCase: XCTestCase) {
        self.testCase = testCase
    }
    
    func expectLoginSuccess() {
        expectation = testCase.expectation(description: "Expect success login")
    }
    
    // MARK: - LogInViewModelDelegate:
    func loginSuccess() {
        expectation?.fulfill()
        expectation = nil
    }
}

class LogInViewModelTests: XCTestCase {
    var sut: LogInViewModel!
    
    override func setUp() {
        UserData.reset()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testFailingLogin() {
        let exp = expectation(description: "Expect failing login")
        var testError: Error?
        sut = LogInViewModel(authorizationService: Authorization(configurations: [.login : .fail]))
        sut.subscribe { error in
            testError = error
            
            exp.fulfill()
        }
        
        sut.login(email: "fake", password: "fake")
        
        waitForExpectations(timeout: 3.0) { error in
            XCTAssertNil(error)
            XCTAssertNotNil(testError)
            XCTAssertEqual(testError?.localizedDescription, "Login error occured...")
            // Failed login
            XCTAssertNil(UserData.token)
            // No current user data
            XCTAssertNil(UserData.currentUser?.email)
        }
    }
    
    func testFailingCurrentUser() {
        let exp = expectation(description: "Expect failing current user fetch")
        var testError: Error?
        let failingService = Authorization(configurations: [.login: .mock, .user : .fail])
        sut = LogInViewModel(authorizationService: failingService)
        sut.subscribe { error in
            testError = error
            
            exp.fulfill()
        }
        
        sut.login(email: "fake", password: "fake")
        
        waitForExpectations(timeout: 3.0) { error in
            XCTAssertNil(error)
            XCTAssertNotNil(testError)
            XCTAssertEqual(testError?.localizedDescription, "User error occured...")
            // Successfull login:
            // check token
            XCTAssertEqual(UserData.token, "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjNhZjE0NGFlYTIyYmFlMmYyYjJjMTljNzEzMjhlMWMxOGQ3ZGMyYWJlYmZlNTZmZGZiMWQwYTAxZDA1NDU3OTc2YTZkMDIzY2U5NGMxNTc4In0.eyJhdWQiOiIxIiwianRpIjoiM2FmMTQ0YWVhMjJiYWUyZjJiMmMxOWM3MTMyOGUxYzE4ZDdkYzJhYmViZmU1NmZkZmIxZDBhMDFkMDU0NTc5NzZhNmQwMjNjZTk0YzE1NzgiLCJpYXQiOjE2MDQ1MTMxMTIsIm5iZiI6MTYwNDUxMzExMiwiZXhwIjoxNjM2MDQ5MTEyLCJzdWIiOiI1MzIiLCJzY29wZXMiOltdfQ.WO_KqA42UMxfDBZVYLxR-COc1iEAk8gZ1GX0LDyvwR-TjBQMUuKK_SfOpMddQ994ueMA5dud6J9vbnP02QHheRhepoLdm6tQAfzyHRj86KLNpvOHO03M9cCxuShX8tDYeMRAY-jLtR3R1--g90tn4_e9De_DBqUFGL6rR2ZdsI0braZ40IRZI1bxuyF1GP-GyxJDR9R3IGS7HjPeT6FLfigt-AEsFGgq9-Ukn89JfkpIsOh9OUm15DtNhpvXDrTI_5RpQ_EojLfPUpTmcmfc6wwBLHTn8M2Gtg8oy7IBetR73-gsCCs9KfvdR7jBEDork_D0Gzag7dZ-Y517KNPok6oX4UjXsNGgAUjXrDytcrBIffbIoao26NsAO7l7Xet0dxNjetosnJYdaINDgfNxBS8XCeTGExpDXIFcY7T64iYtMkY5ZVr1yjUreOd3FMXxP7cMqAK4v6tLcG28_HnniNXpqWtfxWuPJqSm8PbKJ1N00mtQrQ8ysU_eF3w_MYhV4XQvEaDImF3zKNDtXsXTRNW0agM8pH1dqr-tBuNYlspDfRmkdKqavgP3RN7pd2TN6M5Ty3ep377jYOsZUq0a2FjElIz-5hTbWs3vJDr9-XbG7e6fkMHz80EuAgCFSXNoiNNFrz5bk7y026OcMMJmWEs4vWg7L4NpkxTIsusZ6ng")
            // Failed current user fetch
            XCTAssertNil(UserData.currentUser?.email)
        }
    }
    
    func testSuccessLogin() {
        // GIVEN:
        sut = LogInViewModel(authorizationService: Authorization(type: .mock))
        let mockDelegate = MockLogInViewModelDelegate(testCase: self)
        sut.delegate = mockDelegate
        
        // WHEN:
        mockDelegate.expectLoginSuccess()
        sut.login(email: "fake", password: "fake")
        
        // THEN:
        waitForExpectations(timeout: 3.0) { error in
            XCTAssertNil(error)
            
            // Successfull login:
            // check token
            XCTAssertEqual(UserData.token, "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjNhZjE0NGFlYTIyYmFlMmYyYjJjMTljNzEzMjhlMWMxOGQ3ZGMyYWJlYmZlNTZmZGZiMWQwYTAxZDA1NDU3OTc2YTZkMDIzY2U5NGMxNTc4In0.eyJhdWQiOiIxIiwianRpIjoiM2FmMTQ0YWVhMjJiYWUyZjJiMmMxOWM3MTMyOGUxYzE4ZDdkYzJhYmViZmU1NmZkZmIxZDBhMDFkMDU0NTc5NzZhNmQwMjNjZTk0YzE1NzgiLCJpYXQiOjE2MDQ1MTMxMTIsIm5iZiI6MTYwNDUxMzExMiwiZXhwIjoxNjM2MDQ5MTEyLCJzdWIiOiI1MzIiLCJzY29wZXMiOltdfQ.WO_KqA42UMxfDBZVYLxR-COc1iEAk8gZ1GX0LDyvwR-TjBQMUuKK_SfOpMddQ994ueMA5dud6J9vbnP02QHheRhepoLdm6tQAfzyHRj86KLNpvOHO03M9cCxuShX8tDYeMRAY-jLtR3R1--g90tn4_e9De_DBqUFGL6rR2ZdsI0braZ40IRZI1bxuyF1GP-GyxJDR9R3IGS7HjPeT6FLfigt-AEsFGgq9-Ukn89JfkpIsOh9OUm15DtNhpvXDrTI_5RpQ_EojLfPUpTmcmfc6wwBLHTn8M2Gtg8oy7IBetR73-gsCCs9KfvdR7jBEDork_D0Gzag7dZ-Y517KNPok6oX4UjXsNGgAUjXrDytcrBIffbIoao26NsAO7l7Xet0dxNjetosnJYdaINDgfNxBS8XCeTGExpDXIFcY7T64iYtMkY5ZVr1yjUreOd3FMXxP7cMqAK4v6tLcG28_HnniNXpqWtfxWuPJqSm8PbKJ1N00mtQrQ8ysU_eF3w_MYhV4XQvEaDImF3zKNDtXsXTRNW0agM8pH1dqr-tBuNYlspDfRmkdKqavgP3RN7pd2TN6M5Ty3ep377jYOsZUq0a2FjElIz-5hTbWs3vJDr9-XbG7e6fkMHz80EuAgCFSXNoiNNFrz5bk7y026OcMMJmWEs4vWg7L4NpkxTIsusZ6ng")
            // check currentUser
            XCTAssertEqual(UserData.currentUser?.email, "alexkolomiits@gmail.com")
        }
    }
    
}

