//
//  SettingsProfileViewModel.swift
//  INTITA
//
//  Created by Viacheslav Markov on 03.02.2021.
//

import UIKit
import Foundation

enum ChoosenItem {
    case country
    case city
    case educationForm
    case preferSpecializations
    case educationShift
}

class SettingsProfileViewModel {
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<Sections, LabelItem>
    
    var arrayItems = EditingField.statusList
    private var updateCallback: ProfileViewModelCallback?
    
    var choosenItem: ChoosenItem?
    var selectedItem: LocalizedResponseProtocol?
    var item: [LocalizedResponseProtocol]?

    var selectedItemEducations: [Int]?
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
        case .educationShift:
            item = JSONService<EducationShiftModel>.values
            choosenItem = .educationShift
            guard let educationShift = existingUser?.educationShift else { return }
            selectedItemEducations = [educationShift]
        case .preferedSpecializations:
            item = JSONService<SpecializationModel>.values
            choosenItem = .preferSpecializations
            selectedItemEducations = editingUser?.preferSpecializations
        case .educform:
            item = JSONService<EducationFormModel>.values
            choosenItem = .educationForm
            guard let educationModel = existingUser?.educationShift else { return }
            selectedItemEducations = [educationModel]
        default:
            break
        }
    }
    
    func getValue(at index: Int) -> String? {
        guard let userToEdit = editingUser else { return nil }
        return EditingField.allCases[index].valueFromUser(userToEdit)
    }
    
    func getArrayItems() -> [LabelItem] {
        let labelItems: [LabelItem] = (0..<numberOfStates).map { (index) -> LabelItem in
            let title = arrayItems[index]
            let value = getValue(at: index)
            return LabelItem(id: index, title: title, value: value)
        }
        return labelItems
    }
    
    func prepareSnapshot() -> Snapshot {
        var snapshot = Snapshot()
        snapshot.appendSections([.first])
        snapshot.appendItems(getArrayItems())
        return snapshot
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
    
    func setNewValueToTextField(from index: Int?, from value: String?) {
            guard let index = index else { return }
            switch EditingField(rawValue: index) {
            case .firstName:
                editingUser?.firstName = value
            case .secondName:
                editingUser?.secondName = value
            case .nickname:
                editingUser?.nickname = value
            case .address:
                editingUser?.address = value
            case .phone:
                editingUser?.phone = value
            case .aboutMe:
                editingUser?.aboutMy = value
            case .interests:
                editingUser?.interests = value
            case .education:
                editingUser?.education = value
            case .previousJob:
                editingUser?.prevJob = value
            case .currentJob:
                editingUser?.currentJob = value
            case .aboutUs:
                editingUser?.aboutUs = value
            case .skype:
                editingUser?.skype = value
            case .facebook:
                editingUser?.facebook = value
            case .linkedin:
                editingUser?.linkedin = value
            case .twitter:
                editingUser?.twitter = value
            default:
                break
            }
        }
    
    func selectEducation(_ selectedEducation: [Int]) {
        switch choosenItem {
        case .preferSpecializations:
            editingUser?.preferSpecializations = selectedEducation
            self.selectedItemEducations = selectedEducation
        case .educationForm:
            editingUser?.educform = selectedEducation.first
            self.selectedItemEducations = selectedEducation
        case .educationShift:
            editingUser?.educationShift = selectedEducation.first
            self.selectedItemEducations = selectedEducation
        default:
            break
        }
        updateCallback?(nil)
    }
}
