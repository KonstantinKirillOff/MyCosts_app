//
//  CostModel.swift
//  MyCosts_app
//
//  Created by Константин Кириллов on 06.01.2022.
//

import Foundation

struct Cost: Identifiable, Codable {
    let id = UUID()
    let name: String
    let typeCost: String
    let ammount: Int
}

class Expenses: ObservableObject {
    @Published var costs = [Cost]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let data = try? encoder.encode(costs) {
                UserDefaults.standard.set(data, forKey: "costs")
            }
        }
    }
    
    init() {
        if let costsData = UserDefaults.standard.value(forKey: "costs") {
            let decoder = JSONDecoder()
            
            if let costs = try? decoder.decode([Cost].self, from: costsData as! Data) {
                self.costs = costs
            }
        }
    }
}

