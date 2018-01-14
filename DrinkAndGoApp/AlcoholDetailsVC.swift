//
//  AlcoholDetailsVC.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 06.01.2018.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import UIKit

protocol AlcoholDetailsDelegate : class {
    func setAlcohol(volume: String?, percentage: String?)
}
class AlcoholDetailsVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var layerView: UIView!
    @IBOutlet weak var alcVolumeCorrection: UITextField!
    @IBOutlet weak var alcVolumeLabel: UILabel!
    @IBOutlet weak var alcPercentageCorrection: UITextField!
    @IBOutlet weak var alcTitleLabel: UILabel!
    @IBOutlet weak var mlOunceSwitch: RoundedSwitch!
    var delegate : AlcoholDetailsDelegate?
    var viewModel : AlcoholDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayerView()
        configureScrollView()
        addNotifications()
        self.alcTitleLabel.text = viewModel.title
        self.alcPercentageCorrection.placeholder = viewModel.alcPercentage
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private func addNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(AlcoholDetailsVC.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AlcoholDetailsVC.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    private func configureLayerView() {
        self.layerView.layer.cornerRadius = 12
        self.layerView.layer.masksToBounds = true
        self.layerView.layer.borderWidth = 1
        self.layerView.layer.borderColor = UIColor.white.cgColor
    }
    private func configureScrollView() {
        self.view.layoutIfNeeded()
        self.scrollView.contentSize = CGSize(width: self.layerView.frame.size.width, height: self.layerView.frame.size.height + 1)
    }
    // MARK: - UITextField
    @IBAction func alcPercentageChanged(_ sender: UITextField) {
        sender.text = self.viewModel.filterPercentage(percentage: sender.text!)
            if let _ = sender.selectedTextRange {
                switch sender.text?.count {
                case 2?: correctPosition(textField: sender, offset: 1)
                case 3?: correctPosition(textField: sender, offset: 2)
                default: return
                }
            }
    }
    private func correctPosition(textField: UITextField, offset: Int) {
        if let newPosition = textField.position(from: textField.beginningOfDocument, offset: offset) {
            textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
        }
    }
    @IBAction func alcVolumeChanged(_ sender: UITextField) {
        sender.text = self.viewModel.filterVolume(volume: sender.text!, isOunce: self.mlOunceSwitch.rightSelected)
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.alcVolumeCorrection.text = self.viewModel.setDefaultPercentage(percentage: self.alcVolumeCorrection.text!)
    }
    private func checkForEmptyField(textField: UITextField) {
        if let text = textField.text, text.isEmpty {
                let animation = CABasicAnimation(keyPath: "position")
                animation.duration = 0.07
                animation.repeatCount = 4
                animation.autoreverses = true
                animation.fromValue = NSValue.init(cgPoint: CGPoint(x: self.alcVolumeCorrection.center.x - 10, y: self.alcVolumeCorrection.center.y))
                animation.toValue = NSValue.init(cgPoint: CGPoint(x: self.alcVolumeCorrection.center.x + 10, y: self.alcVolumeCorrection.center.y))
                self.alcVolumeCorrection.layer.add(animation, forKey: "position")
        } else {
            self.delegate?.setAlcohol(volume: self.alcVolumeCorrection.text, percentage: self.alcPercentageCorrection.text)
            self.dismiss(animated: true, completion: nil)
        }
    }
   
    // MARK: - Buttons
    @IBAction func cancelButtonAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonAction(_ sender: UIBarButtonItem) {
        checkForEmptyField(textField: self.alcVolumeCorrection)
    }
    // MARK: - Notifications
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
           
            self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, keyboardSize.height, 0)
           
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
           
            self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
            
        }
    }
}
