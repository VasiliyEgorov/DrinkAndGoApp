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
    private let segueID = "AlcoholSegue"
    var viewModel : WeightViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.weightPicker.showsSelectionIndicator = true

        self.weightPicker.selectRow(self.viewModel.setDefaultRow(), inComponent: 0, animated: true)
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
        return self.viewModel.numberOfRowsInComponent()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.viewModel.titleForRow(row: row)
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.viewModel.getSelectedRow(row: row)
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let string = self.viewModel.titleForRow(row: row)
        let rowSize = self.weightPicker.rowSize(forComponent: component)
        return NSAttributedString(string: string, attributes: [NSAttributedStringKey.foregroundColor : UIColor.white,
                                                               NSAttributedStringKey.font : UIFont.init(name: "HelveticaNeue-Thin", size: rowSize.height * 0.8) ?? UIFont.systemFont(ofSize: rowSize.height * 0.8)])
    }
    // MARK: - Buttons
    
    @IBAction func nextButtonAction(_ sender: UIBarButtonItem) {
        self.viewModel.convertRowToWeight()
        self.performSegue(withIdentifier: segueID, sender: nil)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let alcoholVC = segue.destination as? AlcoholVC {
            alcoholVC.viewModel = self.viewModel.setAlcoholViewModel()
            self.navigationController?.pushViewController(alcoholVC, animated: true)
        }
    }
    

}
