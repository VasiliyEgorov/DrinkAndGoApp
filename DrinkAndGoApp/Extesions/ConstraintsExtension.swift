//
//  ConstraintsExtension.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 09.02.2018.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
   
    class func changeMultiplier(_ constraint: NSLayoutConstraint, multiplier: CGFloat) -> NSLayoutConstraint? {
        
        guard let firstItem = constraint.firstItem else { return nil }
        guard let secondItem = constraint.secondItem else { return nil }
        
        let newConstraint = NSLayoutConstraint(
                item: firstItem,
                attribute: constraint.firstAttribute,
                relatedBy: constraint.relation,
                toItem: secondItem,
                attribute: constraint.secondAttribute,
                multiplier: multiplier,
                constant: constraint.constant)
            
            newConstraint.priority = constraint.priority
            
            NSLayoutConstraint.deactivate([constraint])
            NSLayoutConstraint.activate([newConstraint])
            
            return newConstraint
        }
}
