//
//  ListViewModel.swift
//  INTITA
//
//  Created by Viacheslav Markov on 17.02.2021.
//

import Foundation

class ListViewModel {
    
    let items: [LocalizedResponseProtocol]
    
    var selectedItem: LocalizedResponseProtocol?
    var existingUser: CurrentUser?
    
    var numberOfCountry: Int? {
        return items.count
    }
    
    init(items: [LocalizedResponseProtocol], selectedItem: LocalizedResponseProtocol?) {
        self.items = items
        self.selectedItem = selectedItem
    }
    
    func isAlreadySelected(at index: Int) -> Bool {
        return selectedItem?.id == items[index].id
    }
    
    func isGeocode(at index: Int) -> Bool {
        return (items[index] as? CountryModel) != nil
    }
    
    func getGeocode(at index: Int) -> String {
        let countryList = JSONService<CountryModel>.values
        let geocoge = countryList?[index + 1].geocode
        
        return geocoge ?? ""
    }
}
