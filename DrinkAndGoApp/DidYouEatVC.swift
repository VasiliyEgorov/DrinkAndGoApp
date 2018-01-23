//
//  DidYouEatVC.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 30.12.17.
//  Copyright © 2017 VasiliyEgorov. All rights reserved.
//

import UIKit

class DidYouEatVC: UIViewController {
    @IBOutlet weak var eatSwitch: RoundedSwitch!
    private let segueID = "WeightSegue"
    var viewModel : DidYouEatViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func nextButtonAction(_ sender: UIBarButtonItem) {
        self.viewModel.didYouEat = self.eatSwitch.rightSelected
        self.performSegue(withIdentifier: segueID, sender: nil)
    }
    
    @IBAction func eatSwitchValueChanged(_ sender: RoundedSwitch) {
        self.viewModel.didYouEat = self.eatSwitch.rightSelected
    }
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let weightVC = segue.destination as? WeightVC {
            weightVC.viewModel = self.viewModel.setWeightViewModel()
        }
    }
    

}
