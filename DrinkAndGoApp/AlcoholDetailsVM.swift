//
//  AlcoholDetailsVM.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 06.01.2018.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import Foundation

struct AlcoholDetailsViewModel {
    
    var title : String!
    var alcPercentage : String!
    
    init(alcTitle: String, alcPercentage: String) {
        self.title = alcTitle
        self.alcPercentage = alcPercentage
    }
}
