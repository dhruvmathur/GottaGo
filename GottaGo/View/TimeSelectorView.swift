//
//  TimeSelectorView.swift
//  GottaGo
//
//  Created by Dhruv Mathur (LCL) on 4/7/18.
//  Copyright © 2018 Dhruv Mathur (LCL). All rights reserved.
//

import UIKit

class TimeSelectorView: UIViewController {
    
    @IBOutlet weak var homeAddressOutlet: UITextField!
    @IBOutlet weak var workAddressOutlet: UITextField!
    @IBOutlet weak var timeToLeaveWork: UIDatePicker!
    @IBOutlet weak var timeToLeaveHome: UIDatePicker!
    
    @IBAction func saveButtonPressed(_ sender: Any) {        
        propertyKey.userDefaults.set(self.homeAddressOutlet.text!, forKey: "homeAddress")
        propertyKey.userDefaults.set(self.workAddressOutlet.text!, forKey: "workAddress")
        propertyKey.userDefaults.set(Int(self.timeToLeaveWork.date.timeIntervalSince1970), forKey: "workTimePicker")
        propertyKey.userDefaults.set(Int(self.timeToLeaveHome.date.timeIntervalSince1970), forKey: "homeTimePicker")
    }
}
