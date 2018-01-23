//
//  ResultVC.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 17.01.2018.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import UIKit
import UICircularProgressRing

class ResultVC: UIViewController, TimerDelegate {
    
    @IBOutlet weak var timerLabel: titleLabel!
    @IBOutlet weak var progressCircular: UICircularProgressRingView!
    private var timer : EliminationTimer!
    var viewModel: ResultViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCircular()
        setupTimerAndLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.progressCircular.setProgress(value: 100, animationDuration: self.viewModel.setAnimationDurationForCicular()) {
            //notif
        }
    }
    private func setupTimerAndLabel() {
        self.timer = EliminationTimer.init(withSeconds: self.viewModel.setSecondsForTimer())
        self.timer.delegate = self
        self.timerLabel.text = self.viewModel.convertToHoursMinutesSecondsForLabel()
    }
    private func setupCircular() {
        self.progressCircular.minValue = 0
        self.progressCircular.value = 0
        self.progressCircular.maxValue = 100
    }
    // MARK: - Timer Delegate
    func setNewTimeForLabel(timeString: String, progress: Int) {
        self.timerLabel.text = timeString
    }
}
