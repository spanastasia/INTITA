//
//  ApiURL.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 02.11.2020.
//

import Foundation

enum NotificationsType : String{
    case inbox
    case sent
    case system
    case trash
        
}

enum ApiURL {
    case login(email: String, password: String)
    case logout
    case currentUser
    case editUser(user: EditingUser)
    case notifications(notificationsType: String)
    
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
            return ""
        case .notifications:
            if let id = UserData.currentUser?.id {
                return "\(path)\(apiVersion)/notifications/\(id)"
            }
            return ""
        }
    }
    
    var httpMethod: String {
        switch self {
        case .login, .logout:
            return "POST"
        case .currentUser:
            return "GET"
        case .editUser:
            return "PUT"
        case .notifications:
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
            return try? JSONSerialization.data(withJSONObject: json, options: [])
        case .logout, .currentUser:
            return nil
        case .editUser(let user):
            let json =
                [
                    "firstName" : user.firstName ?? "",
                    "secondName" : user.secondName ?? "",
                    "nickname" : user.nickname ?? "",
                    "birthday" : user.birthday ?? "",
                    "country" : user.country?.id ?? 0,
                    "city" : user.city?.id ?? 0,
                    "address" : user.address ?? "",
                    "phone" : user.phone ?? "",
                    "aboutMy" : user.aboutMy ?? "",
                    "interests" : user.interests ?? "",
                    "education" : user.education ?? "",
                    "prevJob" : user.prevJob ?? "",
                    "currentJob" : user.currentJob ?? "",
                    "aboutUs" : user.aboutUs ?? "",
                    "facebook" : user.facebook ?? "",
                    
//                    TODO: I guess there are fields which can not be changed by User
//                    "skype" : user.skype ?? "",
//                    "linkedin" : user.linkedin ?? "",
//                    "twitter" : user.twitter ?? "",
//                    "preferSpecializations" : user.preferSpecializations ?? [""],
//                    "educform" : user.education "",
//                    "educationShift" : user.educationShift ?? 0,
                ] as [String : Any]
            return try? JSONSerialization.data(withJSONObject: json, options: [])
        case .notifications(notificationsType: let notificationsType):
            let json3 = [
                "field": "id",
                "type": "desc"
            ]
            let json2 = [
                "count": 20,
                "page": 1,
                "sorting": [json3],
                "filter": nil
            ] as [String : Any?]
            
            let json = [
                "type": notificationsType,
                "queryParams": json2
            ] as [String : Any]
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
        case .notifications:
            guard let token = UserData.token else {
                return nil
            }
            return ["Content-Type" : "application/json",
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
        case .notifications:
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
        case .notifications:
            return "notifications"
        }
    }

}
