//
//  Timer.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 22.01.2018.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import Foundation

protocol TimerDelegate : class {
    func setNewTimeForLabel(timeString: String, progress: Int)
}

class EliminationTimer {
    
    var eliminationTimer : Timer!
    var delegate : TimerDelegate?
    private let startSeconds : Int
    private var progressUp = 0
    private var progressDown : Int
    
    @objc private func runTimer() {
        let hours = self.progressDown / 3600
        let minutes = (self.progressDown % 3600) / 60
        let seconds = self.progressDown % 60
        self.progressDown -= 1
        self.progressUp += 1
        let valueForCircular = self.progressUp / self.startSeconds * 100
        
        self.delegate?.setNewTimeForLabel(timeString: String.init(format: "%02d:%02d:%02d", hours, minutes, seconds), progress: valueForCircular)
        
        if self.progressDown == -1 {
            self.eliminationTimer.invalidate()
        }
    }
    
    init(withSeconds seconds: Int) {
        self.startSeconds = seconds
        self.progressDown = seconds
        self.eliminationTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimer), userInfo: nil, repeats: true)
    }
}
