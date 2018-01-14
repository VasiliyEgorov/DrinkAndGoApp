//
//  AlcoholCell.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 03.01.2018.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import UIKit
protocol CellsDelegate : class {
    func tapAction(title: String?, alcPercent: String?)
}
class AlcoholCell: UICollectionViewCell {
    @IBOutlet weak var alcPercentLabel: UILabel!
    @IBOutlet weak var cellsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    weak var delegate : CellsDelegate?
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
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapGestureAction(recognizer:)))
        self.contentView.addGestureRecognizer(tapGesture)
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
    // MARK: - Gesture
    
    @objc private func tapGestureAction(recognizer: UITapGestureRecognizer) {
        self.delegate?.tapAction(title: self.titleLabel.text, alcPercent: alcPercentLabel.text)
    }
}
