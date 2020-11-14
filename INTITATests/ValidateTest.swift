//
//  ValidateTest.swift
//  INTITATests
//
//  Created by Viacheslav Markov on 12.11.2020.
//

import XCTest
@testable import INTITA

class ValidateTests: XCTestCase {

    func testValidateEmail() {
        
        let sut = Validate()
        
        var isEmailTrue: Bool
        var isEmailFalse: Bool
        
        isEmailTrue = sut.validateEmail(email: "q@w.e")
        XCTAssertTrue(isEmailTrue)
        isEmailTrue = sut.validateEmail(email: "Q@W.E")
        XCTAssertTrue(isEmailTrue)
        isEmailTrue = sut.validateEmail(email: "sOmE@SoMe.resUlt")
        XCTAssertTrue(isEmailTrue)
        isEmailTrue = sut.validateEmail(email: "1@2.someTEXT")
        XCTAssertTrue(isEmailTrue)
        isEmailTrue = sut.validateEmail(email: "someTextAndSymbols@someTextAndSymbols.someText")
        XCTAssertTrue(isEmailTrue)
        isEmailTrue = sut.validateEmail(email: ".@q.text")
        XCTAssertTrue(isEmailTrue)
        isEmailTrue = sut.validateEmail(email: "-@q.text")
        XCTAssertTrue(isEmailTrue)
        
        isEmailFalse = sut.validateEmail(email: "")
        XCTAssertFalse(isEmailFalse)
        isEmailFalse = sut.validateEmail(email: "1@2.3")
        XCTAssertFalse(isEmailFalse)
        isEmailFalse = sut.validateEmail(email: "@2.3")
        XCTAssertFalse(isEmailFalse)
        isEmailFalse = sut.validateEmail(email: "1@.3")
        XCTAssertFalse(isEmailFalse)
        isEmailFalse = sut.validateEmail(email: "1@2.")
        XCTAssertFalse(isEmailFalse)
        isEmailFalse = sut.validateEmail(email: "1@2.text1")
        XCTAssertFalse(isEmailFalse)
        isEmailFalse = sut.validateEmail(email: "1@2.1text")
        XCTAssertFalse(isEmailFalse)
        isEmailFalse = sut.validateEmail(email: "1@2@.text1")
        XCTAssertFalse(isEmailFalse)
        isEmailFalse = sut.validateEmail(email: "@@2.text")
        XCTAssertFalse(isEmailFalse)
        isEmailFalse = sut.validateEmail(email: "/@q.text")
        XCTAssertFalse(isEmailFalse)
        isEmailFalse = sut.validateEmail(email: " @q.text")
        XCTAssertFalse(isEmailFalse)
        
    }
    
    func testValidatePassword() {
        
        let sut = Validate()
        
        var isPasswordTrue: Bool
        var isPasswordFalse: Bool
        
        isPasswordTrue = sut.validatePassword(password: "11")
        XCTAssertTrue(isPasswordTrue)
        isPasswordTrue = sut.validatePassword(password: "1q")
        XCTAssertTrue(isPasswordTrue)
        isPasswordTrue = sut.validatePassword(password: "qw")
        XCTAssertTrue(isPasswordTrue)
        isPasswordTrue = sut.validatePassword(password: "QW")
        XCTAssertTrue(isPasswordTrue)
        isPasswordTrue = sut.validatePassword(password: "Q1")
        XCTAssertTrue(isPasswordTrue)
        isPasswordTrue = sut.validatePassword(password: "someTextAndNumbers")
        XCTAssertTrue(isPasswordTrue)

        
        isPasswordFalse = sut.validateEmail(email: "")
        XCTAssertFalse(isPasswordFalse)
        isPasswordFalse = sut.validateEmail(email: " ")
        XCTAssertFalse(isPasswordFalse)
        isPasswordFalse = sut.validateEmail(email: "1")
        XCTAssertFalse(isPasswordFalse)
        isPasswordFalse = sut.validateEmail(email: "a")
        XCTAssertFalse(isPasswordFalse)
        isPasswordFalse = sut.validateEmail(email: "-1")
        XCTAssertFalse(isPasswordFalse)
        isPasswordFalse = sut.validateEmail(email: "-f")
        XCTAssertFalse(isPasswordFalse)
        isPasswordFalse = sut.validateEmail(email: "/12")
        XCTAssertFalse(isPasswordFalse)
        isPasswordFalse = sut.validateEmail(email: " 4")
        XCTAssertFalse(isPasswordFalse)
        isPasswordFalse = sut.validateEmail(email: "7 ")
        XCTAssertFalse(isPasswordFalse)
        isPasswordFalse = sut.validateEmail(email: "d 3")
        XCTAssertFalse(isPasswordFalse)
        
    }

}
