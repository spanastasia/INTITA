//
//  SettingsProfileViewModel.swift
//  INTITA
//
//  Created by Viacheslav Markov on 03.02.2021.
//

import Foundation

enum ChoosedItem {
    case country
    case city
}

class SettingsProfileViewModel {
    var arrayItems = EditingField.statusList
    private var updateCallback: ProfileViewModelCallback?
    var selectedCountry: CountryModel?
    var selectedCity: CityModel?
    var choosedItem: ChoosedItem?
    
    var existingUser: CurrentUser?
    
    var numberOfStates: Int {
        EditingField.allCases.count
    }
    
    private var editingUser: EditingUser?
    var isProfileEditing: Bool = false
    
    init(existingUser: CurrentUser) {
        editingUser = EditingUser(from: existingUser)
        
        if let countryId = existingUser.country,
           let cityId = existingUser.city {
            selectedCountry = JSONService<CountryModel>.getValue(by: countryId)
            selectedCity = JSONService<CityModel>.getValue(by: cityId)
        }
        
    }
    
    func isCountryRow(row: Int) -> Bool {
        if row == 4 { choosedItem = .country }
        if row == 5 { choosedItem = .city }
        return (row == 4 && isProfileEditing) || (row == 5 && isProfileEditing)
    }
    
    func getValue(at index: Int) -> String? {
        guard let userToEdit = editingUser else { return nil }
        return EditingField.allCases[index].valueFromUser(userToEdit)
    }
    
    func subscribe(updateCallback: ProfileViewModelCallback?) {
        self.updateCallback = updateCallback
    }

    func selectCountry(_ editingUser: EditingUser) {
        guard CurrentUser(from: editingUser) != nil else { return }
        
        switch choosedItem {
        case .country:
            self.editingUser?.country = editingUser.country
            selectedCountry = editingUser.country
        case .city:
            self.editingUser?.city = editingUser.city
            selectedCity = editingUser.city
        default:
            break
        }
        
        updateCallback?(nil)
    }
    
    func startEditUser() {
        isProfileEditing.toggle()
        updateCallback?(nil)
    }
}
