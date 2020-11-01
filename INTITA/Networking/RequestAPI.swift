//
//  RequestAPI.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 31.10.2020.
//
import Foundation

class RequestAPI {
    private static let path = "https://intita.com/"
    private static let version = "api/v1"
    public static var loginPath: String {
        return "\(path)\(version)/login"
    }
    public static var logoutPath: String {
        return "\(path)\(version)/logout"
    }
    
    public static func request<T: Codable>(url: URL, jsonData: Data?, completitionHandler: @escaping (Result<T, Error>) -> Void) {
        guard let jsonData = jsonData else {
            return
        }
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = session.uploadTask(with: request, from: jsonData) { data, response, error in
            if error != nil {
                completitionHandler(.failure(ApiError.taskError))
                return
            }
            guard let data = data else {
                completitionHandler(.failure(ApiError.noData))
                return
            }
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                completitionHandler(.success(response))
            } catch {
                completitionHandler(.failure(error))
            }
        }
        task.resume()
    }
    
    public static func prepareData(email: String, password: String) -> Data? {
        let json = [
            "email" : email,
            "password" : password
        ]
        guard let data = try? JSONSerialization.data(withJSONObject: json, options: [])
        else { return nil }
        
        return data
    }
    public static func prepareData(token: String) -> Data? {
        let json = [
            "token" : token
        ]
        guard let data = try? JSONSerialization.data(withJSONObject: json, options: [])
        else { return nil }
        
        return data
    }
}
