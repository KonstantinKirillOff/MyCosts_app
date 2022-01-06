//
//  ContentView.swift
//  MyCosts_app
//
//  Created by Константин Кириллов on 06.01.2022.
//

import SwiftUI

struct CostsListView: View {
    
    @State private var showAddForm = false
    @StateObject var expenses = Expenses()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.costs) { cost in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(cost.name)")
                                .bold()
                            Text("\(cost.typeCost)")
                        }
                        Spacer()
                        Text("$\(cost.ammount)")
                    }
                }.onDelete(perform: delete)
            }
            .listStyle(.plain)
            .navigationTitle("My costs")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button(action: {showAddForm.toggle()}) {
                            Image(systemName: "plus")
                        }
                        .sheet(isPresented: $showAddForm) {
                            NewCostView(isPresented: $showAddForm, expenses: expenses)
                        }
                    }
                }
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        expenses.costs.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CostsListView()
    }
}
