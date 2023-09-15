//
//  AllExpensesView.swift
//  MVVMExample
//
//  Created by Anton Gerasimov on 15.09.2023.
//

import SwiftUI

struct AllExpensesView: View {
    
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text(item.amount, format: .currency(code: "USD"))
                    }
                }
                .onDelete(perform: expenses.removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .onAppear() {
                expenses.loadItem()
            }
            .onChange(of: expenses.items) { _ in
                expenses.saveItem()
            }
            .sheet(isPresented: $showingAddExpense) {
                AddExpenseView(expenses: expenses)
            }
        }
    }
}

struct AllExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        AllExpensesView()
    }
    
}
