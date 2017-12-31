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
    private let mensWeightSelectedRow = "88-91 Kg, 187-194 Lbs"
    let weight = ["60-63 Kg, 132-139 Lbs", "64-67 Kg, 140-147 Lbs", "68-71 Kg, 147-154 Lbs", "72-75 Kg, 155-162 Lbs", "76-79 Kg, 163-170 Lbs", "80-83 Kg, 171-178 Lbs", "84-87 Kg, 179-186 Lbs", "88-91 Kg, 187-194 Lbs", "92-95 Kg, 195-202 Lbs", "96-99 Kg, 203-210 Lbs", "100-103 Kg, 211-218 Lbs", "104-107 Kg, 219-226 Lbs", "108-111 Kg, 227-234 Lbs", "112-115 Kg, 235-242 Lbs", "116-119 Kg, 243-250 Lbs", "120-123 Kg, 251-258 Lbs"]
    
    func setSelectedRow() -> Int {
        let row = self.weight.index(of: mensWeightSelectedRow)
        return row!
    }
    init(model: Interview) {
        self.model = model
    }
}
