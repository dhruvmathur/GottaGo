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
        propertyKey.savedHomeAddress = self.homeAddressOutlet.text!
        propertyKey.savedWorkAddress = self.workAddressOutlet.text!
        propertyKey.timeToLeaveWork = self.timeToLeaveWork.date
        propertyKey.timeToLeaveHome = self.timeToLeaveHome.date
    }
}
