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
    private var circularViewModel : CircularViewModel! {
        didSet {
            UserNotificationManager.shared.addNotificationWithTimeIntervalTrigger(time: self.circularViewModel.setAnimationDurationForCicular())
        }
    }
    var viewModel: ResultViewModel! {
        didSet {
            self.circularViewModel = self.viewModel.setCircularViewModel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCircular()
        setupTimerAndLabel()
        setupNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(UIApplicationDidEnterBackground(notification:)), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UIApplicationWillEnterForeground(notification:)), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
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
    func setNewTimeForLabel(timeString: String, progress: CGFloat) {
        self.timerLabel.text = timeString
        self.progressCircular.setProgress(value: progress, animationDuration: 1)
    }
    // MARK: - Notifications
    @objc private func UIApplicationDidEnterBackground(notification: Notification) {
        self.timer.getCurrentTimeAndSave()
    }
    @objc private func UIApplicationWillEnterForeground(notification: Notification) {
        self.timer.updateTimer()
    }
}
