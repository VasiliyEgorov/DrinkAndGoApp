//
//  DataExtension.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 03.01.2018.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import UIKit

extension Data {
    var uiImage : UIImage? {
        return UIImage(data: self)
    }
    
    init?(imageName : String) {
        self.init()
        guard let img = UIImage.init(named: imageName) else { return nil }
        guard let data = img.pngData() else { return nil }
        self = data
    }
}
