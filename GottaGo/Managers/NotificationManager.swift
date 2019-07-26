//
//  NotificationManager.swift
//  GottaGo
//
//  Created by Dhruv Mathur on 2019-06-16.
//  Copyright © 2019 Dhruv Mathur (LCL). All rights reserved.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    static func createNotification() {
        let departureTimeHourFromHome = propertyKey.userDefaults.integer(forKey: "departureHour")
        let departureTimeMinuteFromHome = propertyKey.userDefaults.integer(forKey: "departureMinute")
        
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Time to Go!", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "Pack up your things, we gotta go!",arguments: nil)
        
        var homeTriggerDate = DateComponents()
        homeTriggerDate.hour = departureTimeHourFromHome
        homeTriggerDate.minute = departureTimeMinuteFromHome
        
        let notificationDate: Date = (NSCalendar.current.date(from: homeTriggerDate)?.addingTimeInterval(-(60*15)))!
        
        let calendar = Calendar.current
        
        var notificationDateComponents = DateComponents()
        notificationDateComponents.hour = calendar.component(.hour, from: notificationDate)
        notificationDateComponents.minute = calendar.component(.minute, from: notificationDate)


        let triggerHome = UNCalendarNotificationTrigger(dateMatching: notificationDateComponents, repeats: true)

        // Create the request object.
        let request = UNNotificationRequest(identifier: "DepartureFromHome", content: content, trigger: triggerHome)
        
        // Schedule the request.
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error : Error?) in
            if let theError = error {
                print(theError.localizedDescription)
            }
        }
    }
}
