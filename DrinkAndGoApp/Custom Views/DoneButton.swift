//
//  DoneButton.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 23.01.2018.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import UIKit

class DoneButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setTitle("Done", for: .normal)
        self.setTitleColor(UIColor.white, for: .normal)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTitle("Done", for: .normal)
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.textAlignment = .right
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel?.font = UIFont.init(name: "HelveticaNeue-Light", size: self.frame.size.height * 0.5)
    }
}
