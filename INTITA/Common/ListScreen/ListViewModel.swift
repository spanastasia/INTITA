//
//  ListViewModel.swift
//  INTITA
//
//  Created by Viacheslav Markov on 17.02.2021.
//

import Foundation

class ListViewModel {
    
    private var updateCallback: ProfileViewModelCallback?
    
    let items: [LocalizedResponseProtocol]
    var searchItems: [LocalizedResponseProtocol] = []
    
    var selectedItem: LocalizedResponseProtocol?
    var existingUser: CurrentUser?
    
    var numberOfCountry: Int? {
        return items.count
    }
    
    init(items: [LocalizedResponseProtocol], selectedItem: LocalizedResponseProtocol?) {
        self.items = items
        self.selectedItem = selectedItem
    }
    
    func subscribe(updateCallback: ProfileViewModelCallback?) {
        self.updateCallback = updateCallback
    }
    
    func isAlreadySelected(at index: Int) -> Bool? {
        return (selectedItem?.id == items[index].id) ? true : nil
    }
    
    func isItemType() -> Bool {
        return items.count == JSONService<CountryModel>.values?.count
    }
    
    func filterItems(by string: String) {
        searchItems = string == "" ? items : items.filter { $0.contains(string) }
        updateCallback?(nil)
    }
    
    func resetFilter() {
        searchItems = items
        updateCallback?(nil)
    }
    
    func fetchCountries() {
        // Replace asyncAfter with fetch call when it's ready
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.searchItems = self.items
            self.updateCallback?(nil)
        }
    }
}
