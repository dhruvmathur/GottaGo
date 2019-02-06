//
//  ViewController.swift
//  GottaGo
//
//  Created by Dhruv Mathur (LCL) on 3/21/18.
//  Copyright © 2018 Dhruv Mathur (LCL). All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let googleAPI = API()
    
    @IBOutlet weak var goingToWorkSwitch: UISwitch!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBAction func gottaGoButton(_ sender: Any) {
        activityIndicator.isHidden = false
        ResultScreen.goingToWork = goingToWorkSwitch.isOn
        let apiResult = googleAPI.getNavigation(goingToWork: goingToWorkSwitch.isOn)
        ResultScreen.navigationResult = apiResult
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(goToDifferentView), name: NSNotification.Name(rawValue: "segue"), object: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func goToDifferentView() {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = true
            self.performSegue(withIdentifier: "resultScreen", sender: self)
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

