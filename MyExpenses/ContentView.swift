//
//  ContentView.swift
//  MyExpenses
//
//  Created by Надежда on 2022-07-11.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        //заархивируем данные:
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "items")
            }
        }
    }
    //разархивируем данные, чтобы можно было прочитать:
    init() {
        if let items = UserDefaults.standard.data(forKey: "items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }
    }
}

struct ContentView: View {
    
    @State private var showingAddExpense = false
    @ObservedObject var expenses = Expenses()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                    Spacer()
                        Text("$\(item.amount)")
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("My expenses")
            .navigationBarItems(trailing:
                                    Button(action: {
                showingAddExpense = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: self.expenses)
            }
        }
    }
    
    func removeItems(as offSets: IndexSet) {
        expenses.items.remove(atOffsets: offSets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
