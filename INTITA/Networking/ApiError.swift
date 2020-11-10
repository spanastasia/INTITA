//
//  ApiError.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 01.11.2020.
//

import Foundation

enum ApiError: Error {
    case noData
    case taskError
}

extension ApiError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noData:
            return "no data".localized
        case .taskError:
            return "task error".localized
        }
    }
}
