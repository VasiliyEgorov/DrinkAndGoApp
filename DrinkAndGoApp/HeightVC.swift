//
//  HeightVC.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 23.01.2018.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import UIKit

class HeightVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var heightSwitch: RoundedSwitch!
    @IBOutlet weak var heightPicker: UIPickerView!
    var viewModel : HeightViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.heightPicker.showsSelectionIndicator = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.heightPicker.selectRow(self.viewModel.setDefaultRow(isFt: self.heightSwitch.rightSelected), inComponent: 0, animated: true)
    }
    // MARK: - Picker View Data Source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return self.viewModel.numberOfComponents()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.viewModel.numberOfRowsInComponent(component: component, isFt: self.heightSwitch.rightSelected)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.viewModel.titleForRow(row: row, component: component, isFt: self.heightSwitch.rightSelected)
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.viewModel.getSelectedRow(row: row, component: component, isFt: self.heightSwitch.rightSelected)
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let string = self.viewModel.titleForRow(row: row, component: component, isFt: self.heightSwitch.rightSelected)
        let rowSize = self.heightPicker.rowSize(forComponent: component)
        if let str = string {
        return NSAttributedString(string: str, attributes: [NSAttributedStringKey.foregroundColor : UIColor.white,
                                                               NSAttributedStringKey.font : UIFont.init(name: "HelveticaNeue-Thin", size: rowSize.height * 0.8) ?? UIFont.systemFont(ofSize: rowSize.height * 0.8)])
        } else {
            return nil
        }
    }
    
    @IBAction func heightSwitchValueChanged(_ sender: RoundedSwitch) {
        self.heightPicker.reloadAllComponents()
        self.heightPicker.selectRow(self.viewModel.setDefaultRow(isFt: self.heightSwitch.rightSelected), inComponent: 0, animated: true)
    }
}
