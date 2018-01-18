//
//  AlcoholCell.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 03.01.2018.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import UIKit

class AlcoholCell: UICollectionViewCell {
    @IBOutlet weak var alcPercentLabel: UILabel!
    @IBOutlet weak var cellsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    private let gradientFirstColor = UIColor.init(red: 120.0/255.0, green: 117.0/255.0, blue: 255.0/255.0, alpha: 1).cgColor
    private let gradientSecondColor = UIColor.init(red: 68.0/255.0, green: 162.0/255.0, blue: 252.0/255.0, alpha: 1).cgColor
    private let gradientLayer = CAGradientLayer()
    var viewModel: AlcoholCellViewModel! {
        didSet {
            cellsImageView.image = self.viewModel.alcoholImage?.uiImage
            titleLabel.text = self.viewModel.alcoholTitle
            alcPercentLabel.text = self.viewModel.alcPercent
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.gradientLayer.colors = [gradientFirstColor, gradientSecondColor]
        self.gradientLayer.cornerRadius = 21
        self.gradientLayer.masksToBounds = true
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.gradientLayer.frame = self.bounds
    }
    
}
