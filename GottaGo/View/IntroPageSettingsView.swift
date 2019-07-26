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
        if let homeAddress = self.homeAddressField.text, let workAddress = self.workAddressField.text, homeAddress != "", workAddress != "" {
            propertyKey.userDefaults.set(homeAddress, forKey: "homeAddress")
            propertyKey.userDefaults.set(workAddress, forKey: "workAddress")
            propertyKey.userDefaults.set(Int(self.workTimePicker.date.timeIntervalSince1970), forKey: "workTimePicker")
            propertyKey.userDefaults.set(Int(self.homeTimePicker.date.timeIntervalSince1970), forKey: "homeTimePicker")
        } else {
            showOKMessage(title: "You can enter your details later", message: "You haven't entered your commute, that's okay. Tap the settings button to configure your commute later!")
        }
        propertyKey.userDefaults.set(true, forKey: "com.dhruv.GottaGo")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeAddressField.delegate = self
        workAddressField.delegate = self
        self.hideKeyboardWhenTappedAround()
        
        workTimePicker.setValue(UIColor.white, forKeyPath: "textColor")
        homeTimePicker.setValue(UIColor.white, forKeyPath: "textColor")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension IntroPageSettingsView: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if homeAddressField.text?.isEmpty == false && workAddressField.text?.isEmpty == false {
            proceedButtonOutlet.isEnabled = true
        } else {
            proceedButtonOutlet.isEnabled = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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

