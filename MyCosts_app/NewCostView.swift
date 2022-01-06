//
//  NewCostView.swift
//  MyCosts_app
//
//  Created by Константин Кириллов on 06.01.2022.
//

import SwiftUI

struct NewCostView: View {
    
    @State private var name = ""
    @State private var type = 0
    @State private var amount = ""
    @Binding var isPresented: Bool
    @ObservedObject var expenses: Expenses
    
    let typeCost = ["Private", "Business"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("name", text: $name)
                Picker(selection: $type, label: Text("type cost")) {
                    ForEach(0..<typeCost.count) { item in
                        Text("\(self.typeCost[item])")
                    }
                }
                TextField("ammount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationTitle("Add cost")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if let actualAmount = Int(self.amount) {
                            let cost = Cost(name: self.name, typeCost: typeCost[self.type], ammount: actualAmount)
                            self.expenses.costs.append(cost)
                        }
                        isPresented.toggle()
                    }) {
                        Text("Save")
                    }
                }
                
            }
        }
    }
}

struct NewCostView_Previews: PreviewProvider {
    static var previews: some View {
        NewCostView(isPresented: .constant(false), expenses: Expenses())
    }
}
