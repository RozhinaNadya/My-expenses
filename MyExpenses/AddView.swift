//
//  AddView.swift
//  MyExpenses
//
//  Created by Надежда on 2022-07-11.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = "" //тк textField принимает только строку

    let types = ["Bussines", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Expense name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Expense", text: $amount)
                    .keyboardType(.numberPad) //чтобы были только цифры
            }
            .navigationTitle("Add")
            .navigationBarItems(trailing: Button("Save") {
                guard let intAmount = Int(self.amount) else {return}
                let item = ExpenseItem(name: self.name, type: self.type, amount: intAmount)
                self.expenses.items.append(item)
            })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
