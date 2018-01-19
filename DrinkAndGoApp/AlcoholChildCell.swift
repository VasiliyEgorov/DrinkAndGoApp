//
//  AlcoholChildCell.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 18.01.2018.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import UIKit

class AlcoholChildCell: UICollectionViewCell {
    
    var closeButton : UIButton!
    @IBOutlet weak var imageView: UIImageView!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.closeButton = UIButton.init(type: .custom)
        self.closeButton.frame = CGRect.zero
        self.closeButton.setImage(UIImage.init(named: "closeButton.png"), for: .normal)
        self.closeButton.addTarget(self, action: #selector(closeButtonAction(_:)), for: .touchUpInside)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageView.addSubview(closeButton)
        setConstraintsTo(closeButton: self.closeButton, andToAlcImageView: self.imageView)
    }
    // MARK: - Button Action
    
    @objc private func closeButtonAction(_ sender: UIButton) {
        
    }
    
    // MARK: - Constraints
    private func setConstraintsTo(closeButton: UIButton, andToAlcImageView alcImageView: UIImageView) {
        let top = NSLayoutConstraint.init(item: closeButton, attribute: .top, relatedBy: .equal, toItem: alcImageView, attribute: .top, multiplier: 1, constant: 4)
        let trailing = NSLayoutConstraint.init(item: closeButton, attribute: .trailing, relatedBy: .equal, toItem: alcImageView, attribute: .trailing, multiplier: 1, constant: -4)
        let width = NSLayoutConstraint.init(item: closeButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: alcImageView.frame.size.width / 2)
        let height = NSLayoutConstraint.init(item: closeButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: alcImageView.frame.size.width / 2)
        
        alcImageView.addConstraint(top)
        alcImageView.addConstraint(trailing)
        alcImageView.addConstraint(width)
        alcImageView.addConstraint(height)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
    }
}
