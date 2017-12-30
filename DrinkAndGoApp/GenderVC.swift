//
//  GenderVC.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 30.12.17.
//  Copyright © 2017 VasiliyEgorov. All rights reserved.
//

import UIKit

class GenderVC: UIViewController {
    @IBOutlet weak var genderSwitch: RoundedSwitch!
    var viewModel : GenderViewModel!
    private let segueID = "DidYouEatSeague"
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func genderSwitchValueChanged(_ sender: RoundedSwitch) {
        self.viewModel.gender = self.genderSwitch.rightSelected
    }
    
    @IBAction func nextButtonAction(_ sender: UIBarButtonItem) {
        self.viewModel.gender = self.genderSwitch.rightSelected
        self.performSegue(withIdentifier: segueID, sender: nil)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let didEatVC = segue.destination as? DidYouEatVC {
            didEatVC.viewModel = self.viewModel.instantiateNextViewModel()
        }
    }
    

}
