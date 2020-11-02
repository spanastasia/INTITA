//
//  Authorization.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 01.11.2020.
//

import Foundation
class Authorization {
    public static func login(email: String, password: String, completition: @escaping (Result<LoginResponse, Error>) -> Void) {
        guard let url = URL(string: RequestAPI.loginPath)
        else {
            return
        }
        let data = RequestAPI.prepareData(email: email, password: password)
        RequestAPI.request(url: url, jsonData: data) { (result: Result<LoginResponse, Error>) in
            completition(result)
        }
    }
    public static func logout(token: String, completition: @escaping (Result<LogoutResponse, Error>) -> Void) {
        guard let url = URL(string: RequestAPI.logoutPath)
        else {
            return
        }
        let sessionConfig = URLSessionConfiguration.default

        let authValue: String = "Bearer \(token)"

        sessionConfig.httpAdditionalHeaders = ["Authorization": authValue]

        let session = URLSession(configuration: sessionConfig)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                completition(.failure(ApiError.taskError))
                return
            }
            guard let data = data else {
                completition(.failure(ApiError.noData))
                return
            }
            do {
                let response = try JSONDecoder().decode(LogoutResponse.self, from: data)
                completition(.success(response))
            } catch {
                completition(.failure(error))
            }
        }
        task.resume()
    }
}
