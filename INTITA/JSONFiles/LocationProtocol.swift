//
//  LocationProtocol.swift
//  INTITA
//
//  Created by Anastasiia Spiridonova on 12.02.2021.
//

import Foundation

protocol LocationProtocol: Codable {
    var id: Int { get set }
    var titleUA: String { get set }
    var titleRU: String { get set }
    var titleEN: String { get set }
    
    var identifier: String { get }
}

enum LocationType {
    case country
    case city
    case specialization
    case educationShift
}
