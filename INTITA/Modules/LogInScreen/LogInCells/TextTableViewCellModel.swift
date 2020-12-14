//
//  TextTableViewCellModel.swift
//  INTITA
//
//  Created by Stepan Niemykin on 24.11.2020.
//

import UIKit

enum TextTableViewCellType {
    case password
    case email
    
    var textContentType: UITextContentType {
        switch self {
        case .password:
            return .password
        case .email:
            return .emailAddress
        }
    }
    
    var isSecureTextEntry: Bool {
        switch self {
        case .password:
            return true
        case .email:
            return false
        }
    }
}

struct TextTableViewCellConfiguration {
    let type: TextTableViewCellType
    let placeholderText: String
}
