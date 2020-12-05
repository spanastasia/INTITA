//
//  CurrentUserTests.swift
//  INTITATests
//
//  Created by  Oleksii Kolomiiets on 02.12.2020.
//

import XCTest
@testable import INTITA

class CurrentUserTests: XCTestCase {
    
    var sut: AuthorizationProtocol!
    
    override func setUp() {
        sut = AuthorizationMock()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testLogin() {
        let exp = expectation(description: "testFetchUser exp")
        XCTAssertNotNil(sut)
        
        var expectedError: Error?
        
        sut.login(email: "fake", password: "fake") { error in
            expectedError = error
            
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0) { expError in
            XCTAssertNil(expError)
            XCTAssertNil(expectedError)
            
            XCTAssertEqual(UserData.token, "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjNhZjE0NGFlYTIyYmFlMmYyYjJjMTljNzEzMjhlMWMxOGQ3ZGMyYWJlYmZlNTZmZGZiMWQwYTAxZDA1NDU3OTc2YTZkMDIzY2U5NGMxNTc4In0.eyJhdWQiOiIxIiwianRpIjoiM2FmMTQ0YWVhMjJiYWUyZjJiMmMxOWM3MTMyOGUxYzE4ZDdkYzJhYmViZmU1NmZkZmIxZDBhMDFkMDU0NTc5NzZhNmQwMjNjZTk0YzE1NzgiLCJpYXQiOjE2MDQ1MTMxMTIsIm5iZiI6MTYwNDUxMzExMiwiZXhwIjoxNjM2MDQ5MTEyLCJzdWIiOiI1MzIiLCJzY29wZXMiOltdfQ.WO_KqA42UMxfDBZVYLxR-COc1iEAk8gZ1GX0LDyvwR-TjBQMUuKK_SfOpMddQ994ueMA5dud6J9vbnP02QHheRhepoLdm6tQAfzyHRj86KLNpvOHO03M9cCxuShX8tDYeMRAY-jLtR3R1--g90tn4_e9De_DBqUFGL6rR2ZdsI0braZ40IRZI1bxuyF1GP-GyxJDR9R3IGS7HjPeT6FLfigt-AEsFGgq9-Ukn89JfkpIsOh9OUm15DtNhpvXDrTI_5RpQ_EojLfPUpTmcmfc6wwBLHTn8M2Gtg8oy7IBetR73-gsCCs9KfvdR7jBEDork_D0Gzag7dZ-Y517KNPok6oX4UjXsNGgAUjXrDytcrBIffbIoao26NsAO7l7Xet0dxNjetosnJYdaINDgfNxBS8XCeTGExpDXIFcY7T64iYtMkY5ZVr1yjUreOd3FMXxP7cMqAK4v6tLcG28_HnniNXpqWtfxWuPJqSm8PbKJ1N00mtQrQ8ysU_eF3w_MYhV4XQvEaDImF3zKNDtXsXTRNW0agM8pH1dqr-tBuNYlspDfRmkdKqavgP3RN7pd2TN6M5Ty3ep377jYOsZUq0a2FjElIz-5hTbWs3vJDr9-XbG7e6fkMHz80EuAgCFSXNoiNNFrz5bk7y026OcMMJmWEs4vWg7L4NpkxTIsusZ6ng")
        }
    }

    func testFetchUser() {
        let exp = expectation(description: "testFetchUser exp")
        XCTAssertNotNil(sut)
        
        var expectedError: Error?
        
        sut.fetchUserInfo { error in
            expectedError = error
            
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3.0) { expError in
            XCTAssertNotNil(expError)
            XCTAssertNotNil(expectedError)
        }
    }

}
