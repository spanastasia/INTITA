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
    
    var existingUser: CurrentUser
    
    init(existingUser: CurrentUser) {
        self.existingUser = existingUser
    }
    
    func getValue(at index: Int) -> String? {
        return EditingFild.allCases[index].valueFromUser(existingUser)
    }
}
