//
//  DidYouEatVM.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 30.12.17.
//  Copyright © 2017 VasiliyEgorov. All rights reserved.
//

import Foundation

struct DidYouEatViewModel {
    private var model : Interview
    private var weightViewModel : WeightViewModel!
    var didYouEat : Bool {
        didSet {
            self.model.didEat = self.didYouEat
        }
    }
    mutating func instantiateNextViewModel() -> WeightViewModel {
        self.weightViewModel = WeightViewModel(model: model)
        return self.weightViewModel
    }
    init(model: Interview) {
        self.init(model: model)
    }
}
