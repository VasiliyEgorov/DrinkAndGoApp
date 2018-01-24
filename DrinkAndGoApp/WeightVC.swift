//
//  WeightVC.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 30.12.17.
//  Copyright © 2017 VasiliyEgorov. All rights reserved.
//

import UIKit

class WeightVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var weightSwitch: RoundedSwitch!
    @IBOutlet weak var weightPicker: UIPickerView!
    private let segueID = "AlcoholSegue"
    private var childController : HeightVC!
    var viewModel : WeightViewModel! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.childController = self.childViewControllers[0] as! HeightVC
        self.childController.viewModel = self.viewModel.setHeightViewModel()
        self.weightPicker.showsSelectionIndicator = true
        self.nextButton.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.weightPicker.selectRow(self.viewModel.setDefaultRow(isLbs: self.weightSwitch.rightSelected), inComponent: 0, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.nextButton.isEnabled = true
        }
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
        return NSAttributedString(string: str, attributes: [NSAttributedStringKey.foregroundColor : UIColor.white,
                                                               NSAttributedStringKey.font : UIFont.init(name: "HelveticaNeue-Thin", size: rowSize.height * 0.8) ?? UIFont.systemFont(ofSize: rowSize.height * 0.8)])
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
