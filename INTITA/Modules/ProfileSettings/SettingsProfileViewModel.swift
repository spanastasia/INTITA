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
    var selectedBirthday: String?
    
    var numberOfStates: Int {
        EditingField.allCases.count
    }
    
    private var editingUser: EditingUser?
    var isProfileEditing: Bool = false
    
    init(existingUser: CurrentUser) {
        editingUser = EditingUser(from: existingUser)
        
        if let birthday = existingUser.birthday {
            selectedBirthday = birthday
        }
    }
    
    func isItemRow(row: Int) {
        
        switch EditingField(rawValue: row) {
        case .country:
            item = JSONService<CountryModel>.values ?? []
            choosenItem = .country
            selectedItem = editingUser?.country
        case .city where editingUser?.country?.id == 1:
            item = JSONService<CityModel>.values ?? []
            choosenItem = .city
            selectedItem = editingUser?.city
        case .city:
            item = nil
        default:
            break
        }
    }
    
    func getValue(at index: Int) -> String? {
        guard let userToEdit = editingUser else { return nil }
        return EditingField.allCases[index].valueFromUser(userToEdit)
    }
    
    func getArrayItems() -> [LabelItem] {
        let labelItems: [LabelItem] = (0..<EditingField.allCases.count).map { (index) -> LabelItem in
            let title = arrayItems[index]
            let value = getValue(at: index)
            return LabelItem(id: index, title: title, value: value)
        }
        return labelItems
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
    
    func isEnableItem(with index: Int) -> Bool {
        return EditingField(rawValue: index)?.enabletItem == EnableCell.link
    }
    
    func getTypeEditingCell(with index: Int) -> CellType? {
        return EditingField(rawValue: index)?.editType
    }
    
    func selectBirthday(_ selectedBirthday: String) {
        editingUser?.birthday = selectedBirthday
        self.selectedBirthday = selectedBirthday
        updateCallback?(nil)
    }
    
    func putEditingUser() {
        guard let editingUser = editingUser else { return }
        Authorization.shared.editUserInfo(newUser: editingUser) { [weak self] result  in
            guard let self = self else { return }
            switch result {
            case .success:
                guard let user = CurrentUser(from: editingUser) else { return }
                UserData.set(currentUser: user)
            case .failure(let error):
                self.updateCallback?(error)
            }
        }
    }
}
