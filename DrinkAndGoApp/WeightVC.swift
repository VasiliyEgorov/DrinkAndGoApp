//
//  WeightVC.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 30.12.17.
//  Copyright © 2017 VasiliyEgorov. All rights reserved.
//

import UIKit

class WeightVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var weigthSwitchWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var weightSwitchHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var weightSwitch: RoundedSwitch!
    @IBOutlet weak var weightPicker: UIPickerView!
    private let segueID = "AlcoholSegue"
    private var childController : HeightVC!
    private var animationShowed : Bool = false
    var viewModel : WeightViewModel! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.childController = (self.children[0] as! HeightVC)
        self.childController.viewModel = self.viewModel.setHeightViewModel()
        self.weightPicker.showsSelectionIndicator = true
        self.nextButton.isEnabled = false
        updateConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !self.animationShowed {
           
            self.weightPicker.selectRow(self.viewModel.setDefaultRow(isLbs: self.weightSwitch.rightSelected), inComponent: 0, animated: true)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.nextButton.isEnabled = true
            self.animationShowed = true
            
            }
        }
    }
    
    private func updateConstraints() {
        let device = Device(rawValue: ScreenSize().size)
        switch device {
        case .IpadMini_Air?, .IpadPro10_5?:
            self.titleLabelHeightConstraint = NSLayoutConstraint.changeMultiplier(self.titleLabelHeightConstraint, multiplier: 0.10)
            self.weightSwitchHeightConstraint = NSLayoutConstraint.changeMultiplier(self.weightSwitchHeightConstraint, multiplier: 0.08)
        case .IpadPro12_9?, .Ipad11?:
            self.titleLabelHeightConstraint = NSLayoutConstraint.changeMultiplier(self.titleLabelHeightConstraint, multiplier: 0.09)
            self.weightSwitchHeightConstraint = NSLayoutConstraint.changeMultiplier(self.weightSwitchHeightConstraint, multiplier: 0.06)
            self.weigthSwitchWidthConstraint = NSLayoutConstraint.changeMultiplier(self.weigthSwitchWidthConstraint, multiplier: 0.2)
        default: return
        }
        self.view.updateConstraintsIfNeeded()
    }
    // MARK: - Picker View Data Source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return self.viewModel.numberOfComponents()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.viewModel.numberOfRowsInComponent(component: component, isLbs: self.weightSwitch.rightSelected)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.viewModel.titleForRow(row: row, component: component, isLbs: self.weightSwitch.rightSelected)
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.viewModel.getSelectedRow(row: row, component: component, isLbs: self.weightSwitch.rightSelected)
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let string = self.viewModel.titleForRow(row: row, component: component, isLbs: self.weightSwitch.rightSelected)
        let rowSize = self.weightPicker.rowSize(forComponent: component)
        if let str = string {
        return NSAttributedString(string: str, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white,
                                                               NSAttributedString.Key.font : UIFont.init(name: "HelveticaNeue-Thin", size: rowSize.height * 0.8) ?? UIFont.systemFont(ofSize: rowSize.height * 0.8)])
        } else {
            return nil
        }
    }
    // MARK: - Buttons
    
    @IBAction func nextButtonAction(_ sender: UIBarButtonItem) {
        
        self.performSegue(withIdentifier: segueID, sender: nil)
    }
    
    @IBAction func weightSwitchValueChanged(_ sender: RoundedSwitch) {
        self.weightPicker.reloadAllComponents()
        self.weightPicker.selectRow(self.viewModel.setDefaultRow(isLbs: self.weightSwitch.rightSelected), inComponent: 0, animated: true)
    }
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if let alcoholVC = segue.destination as? AlcoholVC {
            self.childController.viewModel.setWeightForModel(weight: self.viewModel.weight)
            alcoholVC.viewModel = self.childController.viewModel.setAlcoholViewModel()
        }
    }
    

}
