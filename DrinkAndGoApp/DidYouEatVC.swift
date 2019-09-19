//
//  DidYouEatVC.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 30.12.17.
//  Copyright © 2017 VasiliyEgorov. All rights reserved.
//

import UIKit

class DidYouEatVC: UIViewController {
    
    @IBOutlet weak var eatSwitchWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var eatSwitchHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var eatSwitch: RoundedSwitch!
    private let segueID = "WeightSegue"
    var viewModel : DidYouEatViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func updateConstraints() {
        let device = Device(rawValue: ScreenSize().size)
        switch device {
        case .IpadMini_Air?, .IpadPro10_5?:
            self.titleLabelHeightConstraint = NSLayoutConstraint.changeMultiplier(self.titleLabelHeightConstraint, multiplier: 0.05)
            self.eatSwitchHeightConstraint = NSLayoutConstraint.changeMultiplier(self.eatSwitchHeightConstraint, multiplier: 0.04)
            self.eatSwitchWidthConstraint = NSLayoutConstraint.changeMultiplier(self.eatSwitchWidthConstraint, multiplier: 0.4)
        case .IpadPro12_9?, .Ipad11?:
            self.titleLabelHeightConstraint = NSLayoutConstraint.changeMultiplier(self.titleLabelHeightConstraint, multiplier: 0.045)
            self.eatSwitchHeightConstraint = NSLayoutConstraint.changeMultiplier(self.eatSwitchHeightConstraint, multiplier: 0.035)
            self.eatSwitchWidthConstraint = NSLayoutConstraint.changeMultiplier(self.eatSwitchWidthConstraint, multiplier: 0.35)
        default: return
        }
        self.view.updateConstraintsIfNeeded()
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
