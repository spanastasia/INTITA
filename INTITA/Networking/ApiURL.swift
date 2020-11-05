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
    
    var path: String {
        return "https://intita.com/"
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
        }
    }
    
    var httpMethod: String {
        switch self {
        case .login, .logout:
            return "POST"
        }
    }
    
    var bodyParams: Data? {
        switch self {
        case .login(email: let email, password: let password):
            let json = [
                "email" : email,
                "password" : password
            ]
            guard let data = try? JSONSerialization.data(withJSONObject: json, options: [])
            else { return nil }
            return data
        case .logout:
            return nil
        }
    }
    
    var value: String? {
        switch self {
        case .login:
            return "application/json"
        case .logout:
            guard let token = UserData.token else {
                return nil
            }
            return "Bearer \(token)"
        }
    }

    var headerField: String {
        switch self {
        case .login:
            return "Content-Type"
        case .logout:
            return "Authorization"
        }
    }
    
    var request: URLRequest? {
        guard let url = URL(string: self.url) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        
        switch self {
        case .login:
            request.setValue(value, forHTTPHeaderField: headerField)
            request.httpBody = bodyParams
        case .logout:
            request.setValue(value, forHTTPHeaderField: headerField)
        }
        return request
    }
}
