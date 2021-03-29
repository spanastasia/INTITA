//
//  SettingsProfileViewModel.swift
//  INTITA
//
//  Created by Viacheslav Markov on 03.02.2021.
//

import Foundation

enum ChoosenItem {
    case country
    case city
}

class SettingsProfileViewModel {
    var arrayItems = EditingField.statusList
    private var updateCallback: ProfileViewModelCallback?
    
    var choosenItem: ChoosenItem?
    var selectedItem: LocalizedResponseProtocol?
    var item: [LocalizedResponseProtocol]?

    
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
            selectedItem = choosenItem == .country ? item?[countryId] : item?[cityId]
        }
    }
    
    func isCountryRow(row: Int) -> Bool {
        
        var isTrue: Bool = false
        switch EditingField(rawValue: row) {
        case .country:
            item = JSONService<CountryModel>.values ?? []
            choosenItem = .country
            isTrue = true
        case .city where isUkraine():
            choosenItem = .city
            isTrue = true
        default:
            break
        }

        return isTrue
    }
    
    private func isUkraine() -> Bool {
        item = JSONService<CityModel>.values ?? []
        if editingUser?.country?.id == 1 {
            item = JSONService<CityModel>.values ?? []
            return true
        } else {
            item = nil
            return false
        }
    }
    
    func getValue(at index: Int) -> String? {
        guard let userToEdit = editingUser else { return nil }
        return EditingField.allCases[index].valueFromUser(userToEdit)
    }
    
    func subscribe(updateCallback: ProfileViewModelCallback?) {
        self.updateCallback = updateCallback
    }

    func selectItem(_ editingItem: LocalizedResponseProtocol) {
        
        switch choosenItem {
        case .country:
            self.editingUser?.country = editingItem as? CountryModel
            selectedItem = editingUser?.country
            if editingItem.id != 1 {
                editingUser?.city = nil
            }
        case .city:
            self.editingUser?.city = editingItem as? CityModel
            selectedItem = editingUser?.city
        default:
            break
        }
        updateCallback?(nil)
    }
    
    func startEditUser() {
        isProfileEditing.toggle()
        updateCallback?(nil)
    }
    
    func selectBirthday(_ selectedBirthday: String) {
        editingUser?.birthday = selectedBirthday
        updateCallback?(nil)
    }
}
