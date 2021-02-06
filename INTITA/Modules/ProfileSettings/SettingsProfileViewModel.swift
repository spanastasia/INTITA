//
//  SettingsProfileViewModel.swift
//  INTITA
//
//  Created by Viacheslav Markov on 03.02.2021.
//

import Foundation

class SettingsProfileViewModel {
    var arrayItems = UserModel.statusList
    
    var numberOfStates: Int {
        UserModel.allCases.count
    }
}
