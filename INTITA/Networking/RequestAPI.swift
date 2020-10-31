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
    
    static func request(jsonData: Data?, completitionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let jsonData = jsonData else {
            return
        }
        
        let session = URLSession.shared
        
        guard let url = URL(string: "\(path)\(version)/login")
        else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = session.uploadTask(with: request, from: jsonData) { data, response, error in
            completitionHandler(data, response, error)
        }
        
        task.resume()
    }
    
    static func prepareData(email: String, password: String) -> Data? {
        let json = [
            "email" : email,
            "password" : password
        ]
        guard let data = try? JSONSerialization.data(withJSONObject: json, options: [])
        else { return nil }
        
        return data
    }
}
