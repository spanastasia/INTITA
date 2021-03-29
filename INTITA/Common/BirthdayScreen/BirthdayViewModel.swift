//
//  BirthdayViewModel.swift
//  INTITA
//
//  Created by Viacheslav Markov on 29.03.2021.
//

import UIKit

class  BirthdayViewModel {
    
    private var updateCallback: ProfileViewModelCallback?
    var selectedDate: String
    
    init(selectedDate: String) {
        self.selectedDate = selectedDate
    }
    
    func subscribe(updateCallback: ProfileViewModelCallback?) {
        self.updateCallback = updateCallback
    }
    
    func setData(didSelectedDate: String) {
        selectedDate = didSelectedDate
        updateCallback?(nil)
    }
    
}
