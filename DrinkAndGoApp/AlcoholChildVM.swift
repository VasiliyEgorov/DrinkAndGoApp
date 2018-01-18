//
//  AlcoholChildVM.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 18.01.2018.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import Foundation

struct AlcoholChildViewModel {
    
    private var model: Interview
    private var choosenVolume = [Int]()
    private var choosenPercent = [Int]()
    private var resultViewModel : ResultViewModel!
    private var alcImagesArray = [Data]()
    
    func numberOfCells() -> Int {
        return self.alcImagesArray.count
    }
    mutating func removeItemAt(index: Int) {
        self.alcImagesArray.remove(at: index)
    }
    mutating func addNewImage(image: Data?) {
        if let data = image {
        self.alcImagesArray.append(data)
            print(self.alcImagesArray.count)
        }
    }
    func setImageToCellAt(index: Int) -> Data {
        return self.alcImagesArray[index]
    }
    mutating func addAlcohol(volume: String?, percentage: String?) {
        if let vol = volume, let perc = percentage {
            if let volFloat = Int(vol), let percFloat = Int(perc) {
                self.choosenVolume.append(volFloat)
                self.choosenPercent.append(percFloat)
            }
        }
    }
    mutating func setResultViewModel() -> ResultViewModel {
        self.resultViewModel = ResultViewModel.init(model: self.model, volume: self.choosenVolume, percentage: self.choosenPercent)
        return self.resultViewModel
    }
    init(model: Interview) {
        self.model = model
    }
}
