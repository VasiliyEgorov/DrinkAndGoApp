//
//  GenderVC.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 30.12.17.
//  Copyright © 2017 VasiliyEgorov. All rights reserved.
//

import UIKit

class GenderVC: UIViewController {
    
    @IBOutlet weak var genderWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var genderHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var genderSwitch: RoundedSwitch!
    var viewModel : GenderViewModel!
    private let segueID = "DidYouEatSeague"
    
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
            self.genderHeightConstraint = NSLayoutConstraint.changeMultiplier(self.genderHeightConstraint, multiplier: 0.04)
            self.genderWidthConstraint = NSLayoutConstraint.changeMultiplier(self.genderWidthConstraint, multiplier: 0.4)
        case .IpadPro12_9?:
            self.titleLabelHeightConstraint = NSLayoutConstraint.changeMultiplier(self.titleLabelHeightConstraint, multiplier: 0.045)
            self.genderHeightConstraint = NSLayoutConstraint.changeMultiplier(self.genderHeightConstraint, multiplier: 0.035)
            self.genderWidthConstraint = NSLayoutConstraint.changeMultiplier(self.genderWidthConstraint, multiplier: 0.35)
        default: return
        }
        self.view.updateConstraintsIfNeeded()
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
            didEatVC.viewModel = self.viewModel.setDidYouEatViewModel()
        }
    }
    

}
