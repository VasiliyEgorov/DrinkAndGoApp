//
//  AlcoholCell.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 03.01.2018.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import UIKit

class AlcoholCell: UICollectionViewCell {
    @IBOutlet weak var cellsImageView: UIImageView!
    var viewModel: AlcoholCellViewModel! {
        didSet {
            
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
}
