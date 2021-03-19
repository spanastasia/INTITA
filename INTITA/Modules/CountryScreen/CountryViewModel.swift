//
//  CountryViewModel.swift
//  INTITA
//
//  Created by Viacheslav Markov on 17.02.2021.
//

import Foundation

class CountryViewModel {
    
    let countryList = JSONService<CountryModel>.values
    var selectedCountry: CountryModel?
    
    var choosedItem: ChoosedItem?
    var selectedCity: CityModel?
    let cityList = JSONService<CityModel>.values
    var existingUser: CurrentUser
    var editingUser: EditingUser?
    
    var numberOfCountry: Int? {
        var count: Int?
        switch choosedItem {
        case .city:
            count = JSONService<CityModel>.values?.count
        case .country:
            count = JSONService<CountryModel>.values?.count
        default:
            break
        }
        return count
    }
    
    func isAlreadySelected(at index: Int) -> Bool {

//        let city = cityList?[index]
//        let country = countryList?[index]
        
        guard let indexCountry = existingUser.country,
              let indexCity = existingUser.city else { return false }
        
        let currentCity = cityList?[indexCity - 1]
        let currentCountry = countryList?[indexCountry - 1]

        return (countryList?[index] == currentCountry) || (cityList?[index] == currentCity)
    }

    init(existingUser: CurrentUser) {
        self.existingUser = existingUser
        editingUser = EditingUser(from: existingUser)
    }
}
