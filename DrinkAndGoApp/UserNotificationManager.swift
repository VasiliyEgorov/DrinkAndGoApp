//
//  UserNotificationManager.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 24.01.2018.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import UIKit
import UserNotifications

class UserNotificationManager : NSObject {
    
    static let shared = UserNotificationManager()
    
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
    
    func registerNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            // handle error
        }
    }
    func addNotificationWithTimeIntervalTrigger(time: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = "You did it"
        content.body = "Take it easy bro and Good luck"
        content.badge = 1
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: time, repeats: false)
        let request = UNNotificationRequest.init(identifier: "timeInterval", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            // handle error
        }
    }
}
extension UserNotificationManager: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("will present notification")
        completionHandler([.alert, .sound])
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        completionHandler()
    }
}
