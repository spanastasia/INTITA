//
//  RequestAPI.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 31.10.2020.
//
import Foundation

class RequestAPI {
    
    public static func request<T: Codable>(request: URLRequest, completionHandler: @escaping (Result<T, Error>) -> Void) {
        
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
}
