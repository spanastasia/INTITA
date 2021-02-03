//
//  OpportunitiesViewModel.swift
//  INTITA
//
//  Created by Viacheslav Markov on 24.01.2021.
//

import Foundation

class OpportunitiesViewModel {
    
    var numberOfStates: Int {
        Opportunities.allCases.count
    }
    
    func getTitle(for state: State) -> String {
        state.description
    }
}
