//
//  ValidationEmail.swift
//  INTITA
//
//  Created by Viacheslav Markov on 06.11.2020.
//

import Foundation

class ValidateEmail {
    
    func validateEmail(email: String) -> Bool{

        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}"

        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
}
