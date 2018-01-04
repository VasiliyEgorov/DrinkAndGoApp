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
    init(image: Data?, title: String) {
        self.alcoholImage = image
        self.alcoholTitle = title
    }
}
