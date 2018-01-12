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
    private let alcPercent = ["5", "40", "37.5", "12", "13", "16", "45"]
    private var choosenVolume = [Float]()
    private var choosenPercent = [Float]()
    private var alcoholDetailsViewModel : AlcoholDetailsViewModel!
    func numberOfCells() -> Int {
        return images.count
    }
    mutating func setCellsViewModel(row: Int) -> AlcoholCellViewModel? {
        guard row < images.count else { return nil }
        guard row < titles.count else { return nil }
        self.cellViewModel = AlcoholCellViewModel.init(image: self.images[row], title: self.titles[row], alcPercent: self.alcPercent[row])
        return self.cellViewModel
    }
    mutating func setAlcoholDetailsViewModel(title: String?, alcPercentage: String?) -> AlcoholDetailsViewModel {
        if let title = title, let percentage = alcPercentage {
            self.alcoholDetailsViewModel = AlcoholDetailsViewModel.init(alcTitle: title, alcPercentage: percentage)
        }
        return self.alcoholDetailsViewModel
    }
    mutating func addAlcohol(volume: String?, percentage: String?) {
        if let vol = volume, let perc = percentage {
            if let volFloat = Float(vol), let percFloat = Float(perc) {
            self.choosenVolume.append(volFloat)
            self.choosenPercent.append(percFloat)
        }
        }
    }
    init(model: Interview) {
        self.model = model
    }
}
