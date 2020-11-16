//
//  MockNetworking.swift
//  INTITA
//
//  Created by Viacheslav Markov on 14.11.2020.
//

import Foundation

class MockNetworking {
    
    func loadJsonData(file: String) -> Data? {
        
        if let jsonFilePath = Bundle(for: type(of:  self)).path(forResource: file, ofType: "json") {
            let jsonFileURL = URL(fileURLWithPath: jsonFilePath)
            
            if let jsonData = try? Data(contentsOf: jsonFileURL) {
                return jsonData
            }
        }
        
        return nil
    }
    
}

//protocol URLSessionDataTaskProtocol {
//    func resume()
//}
//
//extension URLSessionDataTask: URLSessionDataTaskProtocol {}
//
//class MockURLSessionDataTask: URLSessionDataTaskProtocol {
//    func resume() {}
//}
//
//protocol URLSessionProtocol {
//    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
//}
//
//extension URLSession: URLSessionProtocol {
//    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
//    return (dataTask(with: url, completionHandler: completionHandler) as URLSessionDataTask) as URLSessionDataTaskProtocol
//    }
//}

//class MockURLSession: URLSessionProtocol {
//
//    var dataTask = MockURLSessionDataTask()
//
//    var completionHandler: (Data?, URLResponse?, Error?)
//
//    init(completionHandler: (Data?, URLResponse?, Error?)) {
//        self.completionHandler = completionHandler
//    }
//
//    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
//
//        completionHandler(self.completionHandler.0,
//                          self.completionHandler.1,
//                          self.completionHandler.2)
//
//        return dataTask
//    }
//}
