//
//  CollectableVM.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 17.01.2018.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import Foundation

struct CollectableViewModel {
    
    private var model: Interview
    private var choosenVolume = [Int]()
    private var choosenPercent = [Int]()
    private var resultViewModel : ResultViewModel!
    
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
