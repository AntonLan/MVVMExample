//
//  ExpenseItem.swift
//  MVVMExample
//
//  Created by Anton Gerasimov on 15.09.2023.
//

import Foundation

protocol Expendable: Identifiable, Codable, Equatable {
    var name: String { get }
    var type: String { get }
    var amount: Double { get }
    var types: [String] { get }
}

struct ExpenseItem: Expendable {
    var id = UUID()
    var name: String
    var type: String
    var amount: Double
    var types = ["Buisness", "Personal"]
}
