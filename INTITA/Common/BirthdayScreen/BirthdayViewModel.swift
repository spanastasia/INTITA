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
    var chosedDate: String?
    
    var dateFromString: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "yyyy-MM-dd"
        let date = dateFormatter.date(from: selectedDate)
        return date
    }
    
    init(selectedDate: String) {
        self.selectedDate = selectedDate
        if selectedDate == "" {
            self.selectedDate = "Please, choose your birthday".localized
        }
    }
    
    func subscribe(updateCallback: ProfileViewModelCallback?) {
        self.updateCallback = updateCallback
    }
    
    func setData(didSelectedDate: String) {
        chosedDate = didSelectedDate
        updateCallback?(nil)
    }
    
    func isBirthday() -> String? {
        if chosedDate == nil { return selectedDate }
        return chosedDate == selectedDate ? selectedDate : chosedDate
    }
}
