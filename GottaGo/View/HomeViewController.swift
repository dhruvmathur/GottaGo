//
//  ViewController.swift
//  GottaGo
//
//  Created by Dhruv Mathur (LCL) on 3/21/18.
//  Copyright © 2018 Dhruv Mathur (LCL). All rights reserved.
//

import UIKit
import GoogleMaps

class HomeViewController: UIViewController {
    
    let googleAPI = API()
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var goingToWorkSwitch: UISwitch!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var switchView: UIView!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBAction func gottaGoButton(_ sender: Any) {
        activityIndicator.isHidden = false
        ResultScreenViewController.goingToWork = goingToWorkSwitch.isOn
        let apiResult = googleAPI.getNavigation(goingToWork: goingToWorkSwitch.isOn)
        ResultScreenViewController.navigationResult = apiResult
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switchView.layer.cornerRadius = 8
        buttonStackView.arrangedSubviews.first?.clipsToBounds = true
        buttonStackView.arrangedSubviews.first?.layer.cornerRadius = 10
        buttonStackView.arrangedSubviews.first?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        buttonStackView.arrangedSubviews[1].clipsToBounds = true
        buttonStackView.arrangedSubviews[1].layer.cornerRadius = 10
        buttonStackView.arrangedSubviews[1].layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]

        activityIndicator.isHidden = true
        
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 14.0)
        let mapViewConfig = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        do {
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }

        self.mapView = mapViewConfig

        
        NotificationCenter.default.addObserver(self, selector: #selector(goToDifferentView), name: NSNotification.Name(rawValue: "segue"), object: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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

