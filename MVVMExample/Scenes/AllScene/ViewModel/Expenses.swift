//
//  Expenses.swift
//  MVVMExample
//
//  Created by Anton Gerasimov on 15.09.2023.
//

import SwiftUI

protocol ExpandebleItems: ObservableObject {
    associatedtype Item: Expendable
    var items: [Item] { get set }
    
    func saveItem()
    func loadItem()
    func addItem()
    func removeItems(at offset: IndexSet)
}

class Expenses: ExpandebleItems {
    typealias Item = ExpenseItem
    
    @Published var items = [Item]()
    @Published var item: Item
    
    init() {
        item = Expenses.clearItem()
    }
    
    func addItem() {
        let item = ExpenseItem(name: item.name, type: item.type, amount: item.amount)
        if (item.name.count < 1) { return }
        items.insert(item, at: 0)
    }
    
    static func clearItem() -> Item {
        let item = ExpenseItem(name: "", type: "Personal", amount: 0)
        return item
    }

}

extension ExpandebleItems {
    func saveItem() {
        if let encode = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encode, forKey: "Items")
        }
    }
    
    func loadItem() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([Item].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
    
    func removeItems(at offset: IndexSet) {
        items.remove(atOffsets: offset)
    }
}
