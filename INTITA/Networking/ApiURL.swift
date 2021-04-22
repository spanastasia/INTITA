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
            let json = chosedFieldToSend(editingUser: user)
            return try? JSONSerialization.data(withJSONObject: json, options: [])
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
            return "editUser"
        }
    }
    
    private func chosedFieldToSend(editingUser: EditingUser) -> [String: Any] {
        guard let currentUser = UserData.currentUser else { return [:] }
        var result: [String: Any] = [:]
      
        if currentUser.firstName != editingUser.firstName {
            result["firstName"] = String(editingUser.firstName ?? "")
        }
        if currentUser.secondName != editingUser.secondName {
            result["secondName"] = String(editingUser.secondName ?? "")
        }
        if currentUser.country != editingUser.country?.id {
            result["country"] = editingUser.country?.id
        }
        if currentUser.city != editingUser.city?.id {
            result["city"] = editingUser.city?.id
        }
        if currentUser.nickname != editingUser.nickname {
            result["nickname"] = String(editingUser.nickname ?? "")
        }
        if currentUser.aboutMy != editingUser.aboutMy {
            result["about_my"] = String(editingUser.aboutMy ?? "")
        }
        if currentUser.address != editingUser.address {
            result["address"] = String(editingUser.address ?? "")
        }
        if currentUser.aboutUs != editingUser.aboutUs {
            result["about_us"] = (editingUser.aboutUs ?? "")
        }
        if currentUser.birthday != editingUser.birthday {
            result["birthday"] = String(editingUser.birthday ?? "")
        }
        if currentUser.currentJob != editingUser.currentJob {
            result["current_job"] = (editingUser.currentJob ?? "")
        }
        if currentUser.prevJob != editingUser.prevJob {
            result["prev_job"] = String(editingUser.prevJob ?? "")
        }
        if currentUser.facebook != editingUser.facebook {
            result["facebook"] = String(editingUser.facebook ?? "")
        }
        if currentUser.interests != editingUser.interests {
            result["interests"] = String(editingUser.interests ?? "")
        }
        if currentUser.linkedin != editingUser.linkedin {
            result["linkedin"] = String(editingUser.linkedin ?? "")
        }
        if currentUser.phone != editingUser.phone {
            result["phone"] = String(editingUser.phone ?? "")
        }
        if currentUser.twitter != editingUser.twitter {
            result["twitter"] = String(editingUser.twitter ?? "")
        }
        if currentUser.skype != editingUser.skype {
            result["skype"] = String(editingUser.skype ?? "")
        }
        if currentUser.education != editingUser.education {
            result["education"] = String(editingUser.education ?? "")
        }

        return result
    }
}
