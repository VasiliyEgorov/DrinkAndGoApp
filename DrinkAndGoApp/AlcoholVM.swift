//
//  AlcoholVM.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 02.01.18.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import Foundation

struct AlcoholViewModel {
    private var model : Interview
    private var cellViewModel : AlcoholCellViewModel!
    private let images = [Data.init(imageName: "")]
    private let titles = [""]
    
    func numberOfCells() -> Int {
        return images.count
    }
    init(model: Interview) {
        self.model = model
    }
}
