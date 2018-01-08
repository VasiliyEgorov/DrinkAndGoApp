//
//  Interview.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 30.12.17.
//  Copyright © 2017 VasiliyEgorov. All rights reserved.
//

import Foundation

enum GenderEnum : Int {
    case Male = 0
    case Female = 1
}

struct Interview {
    var gender : GenderEnum!
    var weight : Int!
    var didEat : Bool!
    var volume : Int!
    var alcPercentage : Int!
    var ml : Bool!
}
