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
        print(self.leaveTimePickerOutlet.date.timeIntervalSince1970)
    }
    
    @IBAction func workHomeToggle(_ sender: Any) {
    }
    
    @IBAction func arriveTimePicker(_ sender: UIDatePicker) {
        
    }
    
    @IBAction func gottaGoButton(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

