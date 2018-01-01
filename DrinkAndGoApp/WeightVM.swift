//
//  weightVM.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 30.12.17.
//  Copyright © 2017 VasiliyEgorov. All rights reserved.
//

import Foundation

struct WeightViewModel {
    private var model : Interview
    private let womanWeightSelectedRow = "71-74 Kg, 150-157 Lbs"
    private let mensWeightSelectedRow = "88-91 Kg, 187-194 Lbs"
    private let womanWeight = ["43-46 Kg, 94-101 Lbs", "47-50 Kg, 102-109 Lbs", "51-54 Kg, 110-117 Lbs", "55-58 Kg, 118-125 Lbs", "59-62 Kg, 126-133 Lbs", "63-66 Kg, 134-141 Lbs", "67-70 Kg, 142-149 Lbs", "71-74 Kg, 150-157 Lbs", "75-78 Kg, 158-165 Lbs", "79-82 Kg, 166-173 Lbs", "83-86 Kg, 174-181 Lbs", "87-90 Kg, 182-189 Lbs", "91-94 Kg, 190-197 Lbs", "95-98 Kg, 198-205 Lbs", "99-102 Kg, 206-213 Lbs", "103-106 Kg, 214-221 Lbs"]
    private let mensWeight = ["60-63 Kg, 132-139 Lbs", "64-67 Kg, 140-147 Lbs", "68-71 Kg, 147-154 Lbs", "72-75 Kg, 155-162 Lbs", "76-79 Kg, 163-170 Lbs", "80-83 Kg, 171-178 Lbs", "84-87 Kg, 179-186 Lbs", "88-91 Kg, 187-194 Lbs", "92-95 Kg, 195-202 Lbs", "96-99 Kg, 203-210 Lbs", "100-103 Kg, 211-218 Lbs", "104-107 Kg, 219-226 Lbs", "108-111 Kg, 227-234 Lbs", "112-115 Kg, 235-242 Lbs", "116-119 Kg, 243-250 Lbs", "120-123 Kg, 251-258 Lbs"]
    private var tempString : String?
    private var alcoholViewModel : AlcoholViewModel!
    func setDefaultRow() -> Int {
        switch model.gender {
        case .Male: return self.mensWeight.index(of: mensWeightSelectedRow)!
        case .Female: return self.womanWeight.index(of: womanWeightSelectedRow)!
        default: return 0
        }
    }
    func numberOfRowsInComponent() -> Int {
        switch model.gender {
        case .Male: return self.mensWeight.count
        case .Female: return self.womanWeight.count
        default: return 0
        }
    }
    func titleForRow(row: Int) -> String {
        switch model.gender {
        case .Male: return self.mensWeight[row]
        case .Female: return self.womanWeight[row]
        default: return ""
        }
    }
    mutating func getSelectedRow(row: Int) {
        switch model.gender {
        case .Male: self.tempString = self.mensWeight[row]
        case .Female: self.tempString = self.womanWeight[row]
        default: self.tempString = nil
        }
        
    }
    mutating func convertRowToWeight() {
        if let string = self.tempString {
            guard let minusIndex = string.index(of: "-") else { return }
            let firstString = String(string[string.startIndex...minusIndex])
            guard let space = string.index(of: " ") else { return }
            let secondString = String(string[minusIndex...space])
            guard let firstNumber = Int(firstString) else { return }
            guard let secondNumber = Int(secondString) else { return }
            self.model.weight = secondNumber - firstNumber
        }
    }
    mutating func setAlcoholViewModel() -> AlcoholViewModel {
        self.alcoholViewModel = AlcoholViewModel.init(model: self.model)
        return self.alcoholViewModel
    }
    init(model: Interview) {
        self.model = model
    }
}
