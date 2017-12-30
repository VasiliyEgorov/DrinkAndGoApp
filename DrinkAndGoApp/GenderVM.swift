//
//  GenderVM.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 30.12.17.
//  Copyright © 2017 VasiliyEgorov. All rights reserved.
//

import Foundation

struct GenderViewModel {
    private var model : Interview
    private var didYouEatViewModel : DidYouEatViewModel!
    var gender : Bool {
        didSet {
            switch gender {
            case false: model.gender = GenderEnum.Male
            case true: model.gender = GenderEnum.Female
            }
        }
    }
    mutating func instantiateNextViewModel() -> DidYouEatViewModel {
        self.didYouEatViewModel = DidYouEatViewModel.init(model: self.model)
        return self.didYouEatViewModel
    }
    init(model: Interview) {
        self.init(model: model)
        self.model = model
    }
}
