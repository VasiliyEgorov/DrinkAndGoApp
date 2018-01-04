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
    private let images = [Data.init(imageName: "Beer.png"), Data.init(imageName: "Vodka.png"), Data.init(imageName: "Gin.png"), Data.init(imageName: "Wine.png"),
                          Data.init(imageName: "Champagne.png"), Data.init(imageName: "Vermouth.png"), Data.init(imageName: "Rum.png")]
    private let titles = ["Beer", "Vodka", "Gin" ,"Wine", "Champagne", "Vermouth", "Rum"]
    
    func numberOfCells() -> Int {
        return images.count
    }
    mutating func setCellsViewModel(row: Int) -> AlcoholCellViewModel? {
        guard row < images.count else { return nil }
        guard row < titles.count else { return nil }
        self.cellViewModel = AlcoholCellViewModel.init(image: self.images[row], title: self.titles[row])
        return self.cellViewModel
    }
    init(model: Interview) {
        self.model = model
    }
}
