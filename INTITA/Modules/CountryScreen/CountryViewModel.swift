//
//  CountryViewModel.swift
//  INTITA
//
//  Created by Viacheslav Markov on 17.02.2021.
//

import Foundation

class CountryViewModel {
    
    let countryList = LocationService<CountryModel>.locations
    
    var numberOfCountry: Int? {
        countryList?.count
    }
    
    var arrayNamesOfCountry: [String]? {
        countryList?.map { $0.titleEN}
    }
}
