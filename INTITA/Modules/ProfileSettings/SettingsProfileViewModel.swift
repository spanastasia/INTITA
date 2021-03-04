//
//  SettingsProfileViewModel.swift
//  INTITA
//
//  Created by Viacheslav Markov on 03.02.2021.
//

import Foundation

class SettingsProfileViewModel {
    var arrayItems = EditingFild.statusList
    private var updateCallback: ProfileViewModelCallback?
    var selectedCountry: CountryModel?
    
    var numberOfStates: Int {
        EditingFild.allCases.count
    }
    
    var existingUser: CurrentUser
    
    init(existingUser: CurrentUser) {
        self.existingUser = existingUser
        
        if let countryId = existingUser.country {
            selectedCountry = LocationService<CountryModel>.getValue(by: countryId)
        }
    }
    
    func getValue(at index: Int) -> String? {
        return EditingFild.allCases[index].valueFromUser(existingUser)
    }
    
    func subscribe(updateCallback: ProfileViewModelCallback?) {
        self.updateCallback = updateCallback
    }

    func selectCountry(_ country: CountryModel) {
        existingUser.country = country.id
        selectedCountry = country
        updateCallback?(nil)
    }
}
