//
//  AlcoholDetailsVC.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 06.01.2018.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import UIKit

fileprivate enum TextFieldEnum : Int {
    case Percentage = 0
    case Volume = 1
}
protocol AlcTupleProtocol {
    typealias AlcTuple = (volume: String?, percentage: String?, isOunce: Bool,indexPath: IndexPath)
}
protocol AlcoholDetailsDelegate : class, AlcTupleProtocol {
    func setAlcohol(tuple: AlcTuple)
}

class AlcoholDetailsVC: UIViewController, UITextFieldDelegate, KeyboardViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var layerView: UIView!
    @IBOutlet weak var alcVolumeCorrection: UITextField!
    @IBOutlet weak var alcVolumeLabel: UILabel!
    @IBOutlet weak var alcPercentageCorrection: UITextField!
    @IBOutlet weak var alcTitleLabel: UILabel!
    @IBOutlet weak var mlOunceSwitch: RoundedSwitch!
    var delegate : AlcoholDetailsDelegate?
    var viewModel : AlcoholDetailsViewModel!
    private var keyboardView: KeyboardView!
    private var bottomConstraint : NSLayoutConstraint!
    private var txtFieldEnum : TextFieldEnum?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayerView()
        configureScrollView()
        addNotifications()
        addKeyboardView()
        self.alcTitleLabel.text = viewModel.title
        self.alcPercentageCorrection.placeholder = viewModel.alcPercentageEdited
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func addKeyboardView() {
        self.keyboardView = KeyboardView.init(frame: CGRect.zero)
        self.view.addSubview(self.keyboardView)
        self.keyboardView.delegate = self
        self.keyboardView.isHidden = true
        let leading = NSLayoutConstraint.init(item: self.keyboardView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint.init(item: self.keyboardView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
        let equalHeight = NSLayoutConstraint.init(item: self.keyboardView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0.05, constant: 0)
        self.bottomConstraint = NSLayoutConstraint.init(item: self.keyboardView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0)
        
        self.keyboardView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addConstraint(leading)
        self.view.addConstraint(trailing)
        self.view.addConstraint(equalHeight)
        self.view.addConstraint(self.bottomConstraint)
    }
    private func addNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(AlcoholDetailsVC.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AlcoholDetailsVC.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AlcoholDetailsVC.keyboardDidShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
    }
    private func configureLayerView() {
        self.layerView.layer.cornerRadius = 12
        self.layerView.layer.masksToBounds = true
        self.layerView.layer.borderWidth = 1
        self.layerView.layer.borderColor = UIColor.white.cgColor
    }
    private func configureScrollView() {
        self.scrollView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        self.scrollView.contentSize = CGSize(width: self.layerView.frame.size.width, height: self.layerView.frame.size.height)
    }
    // MARK: - UITextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.txtFieldEnum = TextFieldEnum.init(rawValue: textField.tag)
        
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let _ = textField.selectedTextRange {
            switch textField.text?.count {
            case 1?: correctPosition(textField: textField, offset: 1)
            case 2?: correctPosition(textField: textField, offset: 1)
            case 3?: correctPosition(textField: textField, offset: 2)
            default: return
            }
        }
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
       self.alcPercentageCorrection.text = self.viewModel.setDefaultPercentage(percentage: self.alcPercentageCorrection.text)
        return true
    }
    
    // MARK: - UITextField
    private func closeKeyboard() {
        switch self.txtFieldEnum {
        case .Percentage?: self.alcPercentageCorrection.resignFirstResponder()
        case .Volume?: self.alcVolumeCorrection.resignFirstResponder()
        default: return
        }
    }
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
    
    private func checkForEmptyFields(alcVolume: UITextField, alcPercentage: UITextField) {
        if let text = alcVolume.text, text.isEmpty {
                let animation = CABasicAnimation(keyPath: "position")
                animation.duration = 0.07
                animation.repeatCount = 3
                animation.autoreverses = true
                animation.fromValue = NSValue.init(cgPoint: CGPoint(x: self.alcVolumeCorrection.center.x - 10, y: self.alcVolumeCorrection.center.y))
                animation.toValue = NSValue.init(cgPoint: CGPoint(x: self.alcVolumeCorrection.center.x + 10, y: self.alcVolumeCorrection.center.y))
                self.alcVolumeCorrection.layer.add(animation, forKey: "position")
        } else {
            self.delegate?.setAlcohol(tuple: self.viewModel.correctAlcBeforeExit(volume: self.alcVolumeCorrection.text, percentage: self.alcPercentageCorrection.text, isOunce: self.mlOunceSwitch.rightSelected, indexPath: self.viewModel.indexPath))
            closeKeyboard()
            self.dismiss(animated: true, completion: nil)
        }
    }
   
    // MARK: - Buttons
    @IBAction func cancelButtonAction(_ sender: UIBarButtonItem) {
        closeKeyboard()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonAction(_ sender: UIBarButtonItem) {
        checkForEmptyFields(alcVolume: self.alcVolumeCorrection, alcPercentage: self.alcPercentageCorrection)
    }
    // MARK: - KeyboardView Delegate
    func upButtonPressed(button: UIButton) {
        switch self.txtFieldEnum {
        case .Volume?:
            self.scrollView.scrollRectToVisible(self.alcTitleLabel.frame, animated: true)
            self.alcPercentageCorrection.becomeFirstResponder()
        default: return
        }
    }
    
    func downButtonPressed(button: UIButton) {
        switch self.txtFieldEnum {
        case .Percentage?:
            self.scrollView.scrollRectToVisible(self.alcVolumeCorrection.frame, animated: true)
            self.alcVolumeCorrection.becomeFirstResponder()
        default: return
        }
    }
    
    func doneButtonPressed(button: UIButton) {
        closeKeyboard()
    }
    // MARK: - Notifications
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, keyboardSize.height, 0)
        }
    }
    @objc func keyboardDidShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.bottomConstraint.constant = -keyboardSize.height
            self.keyboardView.isHidden = false
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        self.keyboardView.isHidden = true
        self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
    }
}
