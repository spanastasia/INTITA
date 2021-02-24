//
//  SettingsProfileViewModel.swift
//  INTITA
//
//  Created by Viacheslav Markov on 03.02.2021.
//

import Foundation

class SettingsProfileViewModel {
    
    private var updateCallback: ProfileViewModelCallback?
    
    var arrayItems = EditingFild.statusList

    var selectedCountry: CountryModel?
    let user: CurrentUser
    
    var countryToDisplay: String? {
        guard let selected = selectedCountry?.geocode.localized(locationType: .country)  else {
            return LocationService<CountryModel>.country?.geocode.localized(locationType: .country)
        }
        
        return selected
    }
    
    var numberOfStates: Int {
        EditingFild.allCases.count
    }
    
    init(user: CurrentUser) {
        self.user = user
    }
    
    func subscribe(updateCallback: ProfileViewModelCallback?) {
        self.updateCallback = updateCallback
    }
    
    func selectCountry(_ country: CountryModel) {
        selectedCountry = country
        updateCallback?(nil)
    }
    
    func funWithCounties() -> String? {
        guard let userCountry = user.country else { return nil }
        
        let data = JSONLoader.loadJsonData(file: "Countries")
        let decoder = JSONDecoder()
        let coutries = try! decoder.decode([CountryModel].self, from: data!)
        let ourCountry = coutries.first { country -> Bool in
            country.id == userCountry
        }
        
        return ourCountry?.geocode.localized(locationType: .country)
    }
}
