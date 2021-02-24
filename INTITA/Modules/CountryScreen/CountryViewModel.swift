//
//  CountryViewModel.swift
//  INTITA
//
//  Created by Viacheslav Markov on 17.02.2021.
//

import Foundation

class CountryViewModel {
    
    let countryList = LocationService<CountryModel>.locations
    
    let selectedCountry: CountryModel?
    
    var numberOfCountry: Int? {
        countryList?.count
    }
    
    var arrayNamesOfCountry: [String]? {
        countryList?.map { $0.titleEN}
    }
    
    func isAlreadySelected(at index: Int) -> Bool {
        return selectedCountry == countryList?[index]
    }
    
    init(selectedCountry: CountryModel?) {
        self.selectedCountry = selectedCountry
    }
}
