//
//  CircularVM.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 24.01.2018.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import Foundation

struct CircularViewModel {
    
    private let seconds : Int
    
    func setAnimationDurationForCicular() -> TimeInterval {
        return TimeInterval(self.seconds)
    }
    init(seconds: Int) {
        self.seconds = seconds
    }
}
