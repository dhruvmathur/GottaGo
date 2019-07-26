//
//  TimeSelectorView.swift
//  GottaGo
//
//  Created by Dhruv Mathur (LCL) on 4/7/18.
//  Copyright © 2018 Dhruv Mathur (LCL). All rights reserved.
//

import UIKit
import UserNotifications


class SettingsViewController: UIViewController {
    
    @IBOutlet weak var homeAddressOutlet: UITextField!
    @IBOutlet weak var workAddressOutlet: UITextField!
    @IBOutlet weak var timeToLeaveWork: UIDatePicker!
    @IBOutlet weak var timeToLeaveHome: UIDatePicker!
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        if homeAddressOutlet.text == "" || homeAddressOutlet.text == nil || workAddressOutlet.text == "" || workAddressOutlet.text == nil {
            showOKMessage(title: "Empty Field!", message: "Please fill in your work or home address")
        } else {
            if let homeAddress = self.homeAddressOutlet.text {
                propertyKey.userDefaults.set(homeAddress, forKey: "homeAddress")
            }
            
            if let workAddress = self.workAddressOutlet.text {
                propertyKey.userDefaults.set(workAddress, forKey: "workAddress")
            }
            propertyKey.userDefaults.set(Int(self.timeToLeaveWork.date.timeIntervalSince1970), forKey: "workTimePicker")
            
            propertyKey.userDefaults.set(Int(self.timeToLeaveHome.date.timeIntervalSince1970), forKey: "homeTimePicker")
            
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet var buttonStackView: UIStackView!
    
    override func viewDidLoad() {
        buttonStackView.arrangedSubviews.first?.clipsToBounds = true
        buttonStackView.arrangedSubviews.first?.layer.cornerRadius = 10
        buttonStackView.arrangedSubviews.first?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        buttonStackView.arrangedSubviews[1].clipsToBounds = true
        buttonStackView.arrangedSubviews[1].layer.cornerRadius = 10
        buttonStackView.arrangedSubviews[1].layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]

        timeToLeaveWork.setValue(UIColor.white, forKeyPath: "textColor")
        timeToLeaveHome.setValue(UIColor.white, forKeyPath: "textColor")
        if let homeAddress = propertyKey.userDefaults.string(forKey: "homeAddress"), homeAddress != "" {
            homeAddressOutlet.placeholder = propertyKey.userDefaults.string(forKey: "homeAddress")
        } else {
            homeAddressOutlet.placeholder = "Home Address"
        }
        
        if let workAddress = propertyKey.userDefaults.string(forKey: "workAddress"), workAddress != "" {
            workAddressOutlet.placeholder = propertyKey.userDefaults.string(forKey: "workAddress")
        } else {
            workAddressOutlet.placeholder = "Work Address"
        }
        
        homeAddressOutlet.delegate = self
        workAddressOutlet.delegate = self
        self.hideKeyboardWhenTappedAround()
        
    }
    
    func showOKMessage(title: String, message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            // this code executes after you hit the OK button
            alert.dismiss(animated: false, completion: nil)
        }
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
