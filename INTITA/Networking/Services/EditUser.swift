//
//  EditUser.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 14.02.2021.
//

import Foundation

protocol EditUserProtocol {
    func edit(user: EditingUser, completion: @escaping (Error?) -> Void)
}

class EditUser: EditUserProtocol {
    static let shared = EditUser()
    
    func edit(user: EditingUser, completion: @escaping (Error?) -> Void) {
        
    }
}

class EditUserReal: EditUserProtocol {
    static let shared = EditUserReal()
    
    func edit(user: EditingUser, completion: @escaping (Error?) -> Void) {
        
    }
}

class EditUserMock: EditUserProtocol {
    
    func edit(user: EditingUser, completion: @escaping (Error?) -> Void) {
        
    }
}

class EditUserFailing: EditUserProtocol {
    
    func edit(user: EditingUser, completion: @escaping (Error?) -> Void) {
        
    }
}
