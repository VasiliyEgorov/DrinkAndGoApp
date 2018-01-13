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
class AlcoholDetailsVC: UIViewController {

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
        self.alcTitleLabel.text = viewModel.title
        self.alcPercentageCorrection.placeholder = viewModel.alcPercentage
        NotificationCenter.default.addObserver(self, selector: #selector(AlcoholDetailsVC.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AlcoholDetailsVC.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func alcPercentageChanged(_ sender: UITextField) {
       sender.text = self.viewModel.filterPercentage(percentage: sender.text!)
    }
    @IBAction func alcVolumeChanged(_ sender: UITextField) {
        sender.text = self.viewModel.filterVolume(volume: sender.text!, ml: self.mlOunceSwitch.rightSelected)
    }
    @IBAction func cancelButtonAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonAction(_ sender: UIBarButtonItem) {
        self.delegate?.setAlcohol(volume: self.alcVolumeCorrection.text, percentage: self.alcPercentageCorrection.text)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
}