//
//  IntroPageSettingsView.swift
//  GottaGo
//
//  Created by Dhruv Mathur on 2018-08-26.
//  Copyright © 2018 Dhruv Mathur (LCL). All rights reserved.
//

import Foundation
import UIKit

class IntroPageSettingsView: UIViewController {
    
    @IBOutlet weak var homeAddressField: UITextField!
    @IBOutlet weak var workAddressField: UITextField!
    @IBOutlet weak var workTimePicker: UIDatePicker!
    @IBOutlet weak var homeTimePicker: UIDatePicker!
    @IBOutlet weak var proceedButtonOutlet: UIButton!
    
    @IBAction func proceedButton(_ sender: Any) {
        propertyKey.userDefaults.set(self.homeAddressField.text!, forKey: "homeAddress")
        propertyKey.userDefaults.set(self.workAddressField.text!, forKey: "workAddress")
        propertyKey.userDefaults.set(Int(self.workTimePicker.date.timeIntervalSince1970), forKey: "workTimePicker")
        propertyKey.userDefaults.set(Int(self.homeTimePicker.date.timeIntervalSince1970), forKey: "homeTimePicker")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeAddressField.delegate = self
        workAddressField.delegate = self
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension IntroPageSettingsView: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if homeAddressField.text?.isEmpty == false && workAddressField.text?.isEmpty == false {
            proceedButtonOutlet.isEnabled = true
        } else {
            proceedButtonOutlet.isEnabled = false
        }
    }
}

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

