//
//  ApiURL.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 02.11.2020.
//

import Foundation

enum ApiURL {
    case login(email: String, password: String)
    case logout
    case currentUser
    case editUser(user: EditingUser)
    
    var path: String {
        return Bundle.main.object(forInfoDictionaryKey: AppConstans.urlPath) as? String ?? "/"
    }
    var apiVersion: String {
        return "api/v1"
    }
    
    var url: String {
        switch self {
        case .login:
            return "\(path)\(apiVersion)/login"
        case .logout:
            return "\(path)\(apiVersion)/logout"
        case .currentUser:
            return "\(path)\(apiVersion)/currentUser"
        case .editUser:
            if let id = UserData.currentUser?.id {
                return "\(path)\(apiVersion)/editUser/\(id)"
            }
        }
        return ""
    }
    
    var httpMethod: String {
        switch self {
        case .login, .logout:
            return "POST"
        case .currentUser:
            return "GET"
        case .editUser:
            return "PUT"
        }
    }
    
    var bodyParams: Data? {
        switch self {
        case .login(email: let email, password: let password):
            let json = [
                "email" : email,
                "password" : password
            ]
            return try? JSONSerialization.data(withJSONObject: json, options: [])
        case .logout, .currentUser:
            return nil
        case .editUser(let user):
            return try? JSONEncoder().encode(user)
        }
    }
    
    var headerFields: [String: String]? {
        switch self {
        case .login:
            return ["Content-Type" : "application/json"]
        case .logout, .currentUser:
            guard let token = UserData.token else {
                return nil
            }
            return ["Authorization" : "Bearer \(token)"]
        case .editUser:
            guard let token = UserData.token else {
                return nil
            }
            return ["Content-Type" : "application/json",
                    "Accept" : "application/json",
                    "Authorization" : "Bearer \(token)"]
        }
    }
    
    var request: URLRequest? {
        guard let url = URL(string: self.url) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.allHTTPHeaderFields = headerFields
        
        switch self {
        case .login:
            request.httpBody = bodyParams
        case .logout, .currentUser:
            break
        case .editUser:
            request.httpBody = bodyParams
        }
        return request
    }
    
    var mockFileName: String? {
        switch self {
        case .login:
            return "token"
        case .currentUser:
            return "currentUser"
        case .logout:
            return nil
        case .editUser:
            return nil
        }
    }
}
