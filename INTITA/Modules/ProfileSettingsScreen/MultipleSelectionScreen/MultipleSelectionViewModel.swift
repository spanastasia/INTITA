//
//  MultipleSelectionViewModel.swift
//  INTITA
//
//  Created by Viacheslav Markov on 04.05.2021.
//

import UIKit

class MultipleSelectionViewModel {
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, SelectedItem>
    
    var item: [LocalizedResponseProtocol]
    var listItems: [SelectedItem]?
    var selectedItems: [Int]
    
    init(item: [LocalizedResponseProtocol], selectedItem: [Int]) {
        self.item = item
        self.selectedItems = selectedItem
        self.listItems = getArrayItems()
    }
    
    func getArrayItems() -> [SelectedItem] {
        let labelItems: [SelectedItem] = (0..<item.count).map { (index) -> SelectedItem in
            let title = item[index].getLocalizedValue()
            let index = item[index].id
            let isTure = isContainTitle(with: title ?? "")
            return SelectedItem(id: index, title: title ?? "", enabled: isTure)
        }
        return labelItems
    }
    
    func prepareSnapshot() -> Snapshot {
        var snapshot = Snapshot()
        snapshot.appendSections([.first])
        snapshot.appendItems(listItems ?? [])
        return snapshot
    }
    
    func setEnabletToItem(with index: Int) {
        listItems?[index].changedType()
    }
    
    private func isContainTitle(with title: String) -> Bool {
        let arrayTitles = selectedItems.map { index -> String in
            return item[index - 1].getLocalizedValue() ?? ""
        }
        return arrayTitles.contains(title) ? true : false
    }
    
    func setArrayItemsId() -> [Int] {
        var arrayEducations: [Int] = []
        if let listItems = listItems {
            for field in listItems {
                if field.enabled {
                    arrayEducations.append(field.id)
                }
            }
        }
        return arrayEducations
    }
}
