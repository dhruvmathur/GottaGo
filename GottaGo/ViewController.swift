//
//  ViewController.swift
//  GottaGo
//
//  Created by Dhruv Mathur (LCL) on 3/21/18.
//  Copyright © 2018 Dhruv Mathur (LCL). All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var leaveTimePickerOutlet: UIDatePicker!
    
    @IBAction func leaveTimePickerAction(_ sender: Any) {
        
    }
    
    @IBAction func workHomeToggle(_ sender: Any) {
    }
    
    @IBAction func arriveTimePicker(_ sender: UIDatePicker) {
        propertyKey.timeToGetToWork = Int(leaveTimePickerOutlet.date.timeIntervalSince1970)
    }

    @IBAction func gottaGoButton(_ sender: Any) {
        let newAPI = API()
        print(newAPI.makeURL())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let firstLaunch = FirstLaunch()
        if firstLaunch.isFirstLaunch {
            
        }

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

