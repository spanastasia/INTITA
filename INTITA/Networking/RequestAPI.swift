//
//  RequestAPI.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 31.10.2020.
//
import Foundation

enum HTTPType {
    case real
    case mock
}

protocol RequestAPIProtocol {
    func request<T: Codable>(request: URLRequest, completionHandler: @escaping (Result<T, Error>) -> Void)
}

class APIRequest {
        
    static var httpType: HTTPType = .real
    
    static var shared: RequestAPIProtocol {
        
        switch httpType {
        case .mock:
            return MockRequestAPI()
        case .real:
            return RequestAPI()
        }
    }
    
}

class MockRequestAPI: RequestAPIProtocol {
    
    public func request<T: Codable>(request: URLRequest, completionHandler: @escaping (Result<T, Error>) -> Void) {

        guard let data = JSONLoader.loadJsonData(file: "token") else { return }
                
            let response = try? JSONDecoder().decode(T.self, from: data)

        }
       
    }

class RequestAPI: RequestAPIProtocol {
    
    public func request<T: Codable>(request: URLRequest, completionHandler: @escaping (Result<T, Error>) -> Void) {
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                completionHandler(.failure(ApiError.taskError))
                return
            }
            guard let data = data else {
                completionHandler(.failure(ApiError.noData))
                return
            }
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                completionHandler(.success(response))
            } catch {
                completionHandler(.failure(error))
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
}
