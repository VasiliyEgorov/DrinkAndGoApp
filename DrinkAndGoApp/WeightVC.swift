//
//  WeightVC.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 30.12.17.
//  Copyright © 2017 VasiliyEgorov. All rights reserved.
//

import UIKit

class WeightVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
 
    @IBOutlet weak var weightPicker: UIPickerView!
    var viewModel : WeightViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.weightPicker.showsSelectionIndicator = true

        self.weightPicker.selectRow(self.viewModel.setSelectedRow(), inComponent: 0, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Picker View Data Source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.viewModel.weight.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.viewModel.weight[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let string = viewModel.weight[row]
        let rowSize = self.weightPicker.rowSize(forComponent: component)
        return NSAttributedString(string: string, attributes: [NSAttributedStringKey.foregroundColor : UIColor.white,
                                                               NSAttributedStringKey.font : UIFont.init(name: "HelveticaNeue-Thin", size: rowSize.height * 0.8) ?? UIFont.systemFont(ofSize: rowSize.height * 0.8)])
    }
    // MARK: - Buttons
    
    @IBAction func nextButtonAction(_ sender: UIBarButtonItem) {
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
    

}
