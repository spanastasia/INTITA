//
//  SettingsProfileViewModel.swift
//  INTITA
//
//  Created by Viacheslav Markov on 03.02.2021.
//

import Foundation

class SettingsProfileViewModel {
    var arrayItems = EditingFild.statusList
    
    var numberOfStates: Int {
        EditingFild.allCases.count
    }
}
