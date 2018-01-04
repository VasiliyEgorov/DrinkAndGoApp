//
//  AlcoholCell.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 03.01.2018.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import UIKit
protocol CellsDelegate : class {
    func tapAction(recognizer: UITapGestureRecognizer)
}
class AlcoholCell: UICollectionViewCell {
    @IBOutlet weak var cellsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    weak var delegate : CellsDelegate?
    var viewModel: AlcoholCellViewModel! {
        didSet {
            cellsImageView.image = self.viewModel.alcoholImage?.uiImage
            titleLabel.text = self.viewModel.alcoholTitle
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapGestureAction(recognizer:)))
        self.contentView.addGestureRecognizer(tapGesture)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapGestureAction(recognizer:)))
        self.contentView.addGestureRecognizer(tapGesture)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel.layer.cornerRadius = 8.0
        self.titleLabel.layer.borderColor = UIColor.white.cgColor
        self.titleLabel.layer.borderWidth = 1.0
        self.titleLabel.clipsToBounds = true
    }

    // MARK: - Gesture
    
    @objc private func tapGestureAction(recognizer: UITapGestureRecognizer) {
        self.delegate?.tapAction(recognizer: recognizer)
    }
}
