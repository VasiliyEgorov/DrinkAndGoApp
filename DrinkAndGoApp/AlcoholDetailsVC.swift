//
//  AlcoholDetailsVC.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 06.01.2018.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import UIKit
protocol AlcoholDetailsDelegate : class {
    
}
class AlcoholDetailsVC: UIViewController {

    @IBOutlet weak var layerView: UIView!
    @IBOutlet weak var alcVolumeCorrection: UITextField!
    @IBOutlet weak var alcVolumeLabel: UILabel!
    @IBOutlet weak var alcPercentageCorrection: UITextField!
    @IBOutlet weak var alcTitleLabel: UILabel!
    @IBOutlet weak var mlOunceSwitch: RoundedSwitch!
    var delegate : AlcoholDetailsDelegate?
    var viewModel : AlcoholDetailsViewModel! {
        didSet {
            self.alcTitleLabel.text = viewModel.title
            self.alcPercentageCorrection.placeholder = viewModel.alcPercentage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func alcPercentageDidEndEditing(_ sender: UITextField) {
    }
    @IBAction func alcVolumeDidEndEditing(_ sender: UITextField) {
    }
    @IBAction func mlOuncheValueChanged(_ sender: RoundedSwitch) {
    }
    @IBAction func cancelButtonAction(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func doneButtonAction(_ sender: UIBarButtonItem) {
    }
    

}
