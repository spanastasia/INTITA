//
//  MultipleSelectionViewModel.swift
//  INTITA
//
//  Created by Viacheslav Markov on 04.05.2021.
//

import UIKit

class MultipleSelectionViewModel {
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, ButtonItem>
    
    var item: [LocalizedResponseProtocol]
    var listItems: [ButtonItem]?
    var selctedItem: [LocalizedResponseProtocol]?
    var selectedItemString: String
    
    init(item: [LocalizedResponseProtocol], selectedItemString: String) {
        self.item = item
        self.selectedItemString = selectedItemString
        self.listItems = getArrayItems()
    }
    
    func getArrayItems() -> [ButtonItem] {
        let labelItems: [ButtonItem] = (0..<item.count).map { (index) -> ButtonItem in
            let title = item[index].getLocalizedValue()
            let index = item[index].id
            let isTure = isContainTitle(with: title ?? "")
            return ButtonItem(id: index, title: title ?? "", enabled: isTure)
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
        let arrayTitles = selectedItemString.components(separatedBy: ", ")
            return arrayTitles.contains(title) ? true : false
    }
}
