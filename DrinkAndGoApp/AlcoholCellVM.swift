//
//  AlcoholCellVM.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 03.01.2018.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import Foundation

struct AlcoholCellViewModel {
    var alcoholImage : Data?
    var alcoholTitle : String!
    var alcPercent : String!
    
    init(image: Data?, title: String, alcPercent: String) {
        self.alcoholImage = image
        self.alcoholTitle = title
        self.alcPercent = alcPercent
    }
}
