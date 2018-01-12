//
//  alcTextField.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 12.01.2018.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import UIKit

class alcTextField: UITextField {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.textAlignment = .center
        self.textColor = UIColor(red: 29.0/255.0, green: 161.0/255.0, blue: 242.0/255.0, alpha: 1)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.font = UIFont.init(name: "HelveticaNeue-Thin", size: self.frame.size.height * 0.6)
    }
}
