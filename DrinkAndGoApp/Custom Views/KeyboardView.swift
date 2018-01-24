//
//  KeyboardView.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 15.01.2018.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import UIKit

protocol KeyboardViewDelegate : class {
    func upButtonPressed(button: UIButton)
    func downButtonPressed(button: UIButton)
    func doneButtonPressed(button: UIButton)
}

class KeyboardView: UIView {
    private var upButton: UIButton!
    private var downButton: UIButton!
    private var doneButton: DoneButton!
    var delegate: KeyboardViewDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(red: 194.0/255.0, green: 207.0/255.0, blue: 217.0/255.0, alpha: 1)
        addButtons()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    // MARK: - Buttons
    private func addButtons() {
        self.upButton = UIButton.init(type: .custom)
        self.upButton.frame = CGRect.zero
        self.upButton.addTarget(self, action: #selector(upButtonAction(_:)), for: .touchUpInside)
        self.upButton.setImage(UIImage.init(named: "up-arrow.png"), for: .normal)
        self.addSubview(self.upButton)
        self.downButton = UIButton.init(type: .custom)
        self.downButton.frame = CGRect.zero
        self.downButton.addTarget(self, action: #selector(downButtonAction(_:)), for: .touchUpInside)
        self.downButton.setImage(UIImage.init(named: "down-arrow.png"), for: .normal)
        self.addSubview(self.downButton)
        self.doneButton = DoneButton.init(frame: CGRect.zero)
        self.doneButton.addTarget(self, action: #selector(doneButtonAction(_:)), for: .touchUpInside)
        self.addSubview(self.doneButton)
        addConstraintsTo(upButton: self.upButton, downButton: self.downButton, doneButton: self.doneButton)
    }
    @objc private func upButtonAction(_ sender: UIButton) {
        self.delegate?.upButtonPressed(button: sender)
    }
    @objc private func downButtonAction(_ sender: UIButton) {
        self.delegate?.downButtonPressed(button: sender)
    }
    @objc private func doneButtonAction(_ sender: UIButton) {
        self.delegate?.doneButtonPressed(button: sender)
    }
    // MARK: - Constraints
    private func addConstraintsTo(upButton: UIButton, downButton: UIButton, doneButton: UIButton) {
        let centerYUpButton = NSLayoutConstraint.init(item: upButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        let leadingUpButton = NSLayoutConstraint.init(item: upButton, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 16)
        let heightUpButton = NSLayoutConstraint.init(item: upButton, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.3, constant: 0)
        let aspectRatioUpButton = NSLayoutConstraint.init(item: upButton, attribute: .height, relatedBy: .equal, toItem: upButton, attribute: .width, multiplier: 1/2, constant: 0)
        
        upButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraint(centerYUpButton)
        self.addConstraint(leadingUpButton)
        self.addConstraint(heightUpButton)
        upButton.addConstraint(aspectRatioUpButton)
        
        let centerYDownButton = NSLayoutConstraint.init(item: downButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        let leadingDownButton = NSLayoutConstraint.init(item: downButton, attribute: .leading, relatedBy: .equal, toItem: upButton, attribute: .trailing, multiplier: 1, constant: 16)
        let equalWidthDownButton = NSLayoutConstraint.init(item: downButton, attribute: .width, relatedBy: .equal, toItem: upButton, attribute: .width, multiplier: 1, constant: 0)
        let equalHeightDownButton = NSLayoutConstraint.init(item: downButton, attribute: .height, relatedBy: .equal, toItem: upButton, attribute: .height, multiplier: 1, constant: 0)
        
        downButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraint(centerYDownButton)
        self.addConstraint(equalHeightDownButton)
        self.addConstraint(leadingDownButton)
        self.addConstraint(equalWidthDownButton)
        
        let trailingDoneButton = NSLayoutConstraint.init(item: doneButton, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let topDoneButton = NSLayoutConstraint.init(item: doneButton, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let bottomDoneButton = NSLayoutConstraint.init(item: doneButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let aspectRatioDoneButton = NSLayoutConstraint.init(item: doneButton, attribute: .width, relatedBy: .equal, toItem: doneButton, attribute: .height, multiplier: 2/1, constant: 0)
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraint(trailingDoneButton)
        self.addConstraint(topDoneButton)
        self.addConstraint(bottomDoneButton)
        doneButton.addConstraint(aspectRatioDoneButton)
 
    }
}
