//
//  titleLabel.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 31.12.17.
//  Copyright © 2017 VasiliyEgorov. All rights reserved.
//

import UIKit

class TitleLabel: UILabel {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.textColor = .white
        self.adjustsFontSizeToFitWidth = true
        self.textAlignment = .center
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.font = UIFont.init(name: "HelveticaNeue-Thin", size: self.frame.size.height * 0.8)
    }
}
