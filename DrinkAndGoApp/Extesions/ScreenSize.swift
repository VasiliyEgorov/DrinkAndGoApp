//
//  ScreenSize.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 24.01.2018.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import UIKit

enum Device : CGFloat {
    case Iphone6_7_plus = 736
    case Iphone6_7 = 667
    case Iphone5 = 568
    case IphoneX = 812
}

struct ScreenSize {
    
    let size = UIScreen.main.bounds.size.height
}
