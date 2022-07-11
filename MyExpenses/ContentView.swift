//
//  ContentView.swift
//  MyExpenses
//
//  Created by Надежда on 2022-07-11.
//

import SwiftUI

struct ExpenseItem {
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()
}

struct ContentView: View {
    
    @ObservedObject var expenses = Expenses()
    
    var body: some View {
        NavigationView{
            List {
                ForEach(expenses.items, id: \.name) { item in
                    Text(item.name)
                }
            }
            .navigationTitle("My expenses")
            .navigationBarItems(trailing:
                                    Button(action: {
                let expence = ExpenseItem(name: "Test", type: "", amount: 50)
                expenses.items.append(expence)
            }) {
                Image(systemName: "plus")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
