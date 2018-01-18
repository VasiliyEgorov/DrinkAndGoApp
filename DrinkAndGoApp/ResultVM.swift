//
//  ResultVM.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 17.01.2018.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import Foundation

struct ResultViewModel {
    private var model : Interview
    private var volume : [Int]!
    private var percentage : [Int]!
    
    init(model: Interview, volume: [Int], percentage: [Int]) {
        self.model = model
        self.volume = volume
        self.percentage = percentage
    }
}
