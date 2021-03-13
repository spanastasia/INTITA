//
//  SettingsProfileViewModel.swift
//  INTITA
//
//  Created by Viacheslav Markov on 03.02.2021.
//

import Foundation

class SettingsProfileViewModel {
    var arrayItems = EditingField.statusList
    private var updateCallback: ProfileViewModelCallback?
    var selectedCountry: CountryModel?
    
    var numberOfStates: Int {
        EditingField.allCases.count
    }
    
    private var editingUser: EditingUser?
    var isProfileEditing: Bool = false
    
    init(existingUser: CurrentUser) {
        editingUser = EditingUser(from: existingUser)
        
        if let countryId = existingUser.country {
            selectedCountry = JSONService<CountryModel>.getValue(by: countryId)
        }
    }
    func isCountryRow(row: Int) -> Bool {
        return row == 4 && isProfileEditing
    }
    
    func getValue(at index: Int) -> String? {
        guard let userToEdit = editingUser else { return nil }
        return EditingField.allCases[index].valueFromUser(userToEdit)
    }
    
    func subscribe(updateCallback: ProfileViewModelCallback?) {
        self.updateCallback = updateCallback
    }

    func selectCountry(_ country: CountryModel) {
        editingUser?.country = country
        selectedCountry = country
        updateCallback?(nil)
    }
    
    func startEditUser() {
        isProfileEditing.toggle()
        updateCallback?(nil)
    }
}
