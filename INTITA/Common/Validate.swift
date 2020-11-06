//
//  ValidationEmail.swift
//  INTITA
//
//  Created by Viacheslav Markov on 06.11.2020.
//

import Foundation

class Validate {
    
    func validateEmail(email: String) -> Bool {

        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    func validatePassword(password: String) -> Bool {
        
        let passwordRegex = "[A-Z0-9a-z]{2,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
}
