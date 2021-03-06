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
    
    var numberOfCountry: Int? {
        countryList?.count
    }
    
    func isAlreadySelected(at index: Int) -> Bool {
        return selectedCountry == countryList?[index]
    }

    init(selectedCountry: CountryModel?) {
        self.selectedCountry = selectedCountry
    }
}
