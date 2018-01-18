//
//  CollectableView.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 17.01.2018.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import UIKit

class CollectableView: UIView {
    @IBOutlet var scrollView : UIScrollView!
    private var alcImageViewArray = [UIImageView!]()
    private let offset : CGFloat = 4.0
    var viewModel: CollectableViewModel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.scrollView.showsHorizontalScrollIndicator = false
    }
    func calculateFrameFor(alcoholImageView: UIImageView) {
        let newWidth = self.scrollView.frame.size.width / 3 - offset
        let newHeight = newWidth * 2
        let findWidthDelta = 100.0 * (alcoholImageView.frame.size.width - newWidth) / alcoholImageView.frame.size.width
        let findHeightDelta = 100.0 * (alcoholImageView.frame.size.height - newHeight) / alcoholImageView.frame.size.height
        let newScale = CGAffineTransform.init(scaleX: 1 - (findWidthDelta / 100), y: 1 - (findHeightDelta / 100))
        let newPoint = CGAffineTransform.init(translationX: 0, y: 0)
        animate(alcImageView: alcoholImageView, toNewPoint: newPoint, andNewScale: newScale)
    }
    private func animate(alcImageView: UIImageView, toNewPoint point: CGAffineTransform, andNewScale scale: CGAffineTransform) {
        
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       options: [.curveLinear],
                       animations: {
                        alcImageView.transform = point.concatenating(scale)
        }) { (finished) in
           self.manageNew(alcImageView: alcImageView)
        }
    }
    private func manageNew(alcImageView: UIImageView) {
        self.alcImageViewArray.append(alcImageView)
        self.scrollView.addSubview(alcImageView)
        let closeButton = UIButton.init(type: .custom)
        closeButton.frame = CGRect.zero
        closeButton.tag = self.alcImageViewArray.count
        closeButton.setImage(UIImage.init(named: ""), for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonAction(_:)), for: .touchUpInside)
        alcImageView.addSubview(closeButton)
        setConstraintsTo(closeButton: closeButton, andToAlcImageView: alcImageView)
    }
    // MARK: - Button Action
    
    @objc private func closeButtonAction(_ sender: UIButton) {
        
        
    }
    
    // MARK: - COnstraints
    
    private func setConstraintsTo(closeButton: UIButton, andToAlcImageView alcImageView: UIImageView) {
        let top = NSLayoutConstraint.init(item: closeButton, attribute: .top, relatedBy: .equal, toItem: alcImageView, attribute: .top, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint.init(item: closeButton, attribute: .trailing, relatedBy: .equal, toItem: alcImageView, attribute: .trailing, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint.init(item: closeButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: alcImageView.frame.size.width / 3)
        let height = NSLayoutConstraint.init(item: closeButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: alcImageView.frame.size.width / 3)
        
        alcImageView.addConstraint(top)
        alcImageView.addConstraint(trailing)
        alcImageView.addConstraint(width)
        alcImageView.addConstraint(height)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
    }
}
