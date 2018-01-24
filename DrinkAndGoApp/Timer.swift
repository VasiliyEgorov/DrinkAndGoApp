//
//  Timer.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 22.01.2018.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import UIKit

let kSettingsDateKey = "date"

protocol TimerDelegate : class {
    func setNewTimeForLabel(timeString: String, progress: CGFloat)
}

class EliminationTimer {

    private var eliminationTimer : Timer!
    var delegate : TimerDelegate?
    private let startSeconds : Int
    private var progressUp = 0
    private var progressDown : Int
   // private var secondAfterUpdate : Int!
    
    func invalidateTimer() {
        self.eliminationTimer.invalidate()
    }

    // MARK: - Save
    func getCurrentTimeAndSave() {
        
        let date = Date()
        let userDefaults = UserDefaults.standard
        userDefaults.set(date, forKey: kSettingsDateKey)
        userDefaults.synchronize()
    }
    // MARK: - Load
    func updateTimer() {
        
        let userDefaults = UserDefaults.standard
        
        let units: Set<Calendar.Component> = [.day, .hour, .minute, .second]
        let loadedDate = userDefaults.object(forKey: kSettingsDateKey) as! Date
        let oldComps = Calendar.current.dateComponents(units, from: loadedDate)
        let newDate = Date()
        
        let comps = Calendar.current.dateComponents(units, from: newDate)
        let difference = Calendar.current.dateComponents(units, from: oldComps, to: comps)
        
        var daysInSec = 0
        var hoursInSec = 0
        var minutesInSec = 0
        var secondsInSec = 0
        
        if let days = difference.day {
            daysInSec = days * 86400
        }
        if let hours = difference.hour {
            hoursInSec = hours * 3600
        }
        if let minutes = difference.minute {
            minutesInSec = minutes * 60
        }
        if let sec = difference.second {
            secondsInSec = sec
        }
        
        let secondsInBackground = daysInSec + hoursInSec + minutesInSec + secondsInSec
        self.progressDown -= secondsInBackground
        self.progressUp += secondsInBackground
        
    }
    @objc private func runTimer() {
        
        if self.progressDown <= -1 {
            self.eliminationTimer.invalidate()
            self.delegate?.setNewTimeForLabel(timeString: "00:00:00", progress: 100.0)
        } else {
            let hours = self.progressDown / 3600
            let minutes = (self.progressDown % 3600) / 60
            let seconds = self.progressDown % 60
            self.progressDown -= 1
            self.progressUp += 1
            let valueForCircular = CGFloat(self.progressUp) / CGFloat(self.startSeconds) * 100.0
            self.delegate?.setNewTimeForLabel(timeString: String.init(format: "%02d:%02d:%02d", hours, minutes, seconds), progress: valueForCircular)
            }
    }
    deinit {
        invalidateTimer()
    }
    init(withSeconds seconds: Int) {
        self.startSeconds = seconds
        self.progressDown = seconds
        self.eliminationTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimer), userInfo: nil, repeats: true)
    }
}
