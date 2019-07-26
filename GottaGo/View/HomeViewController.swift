//
//  ViewController.swift
//  GottaGo
//
//  Created by Dhruv Mathur (LCL) on 3/21/18.
//  Copyright © 2018 Dhruv Mathur (LCL). All rights reserved.
//

import UIKit
import GoogleMaps
import UserNotifications

class HomeViewController: UIViewController, UITextFieldDelegate {
    
    enum CardState {
        case expanded
        case collapsed
    }
    
    let googleAPI = API()
    var resultScreenCardController: ResultScreenViewController!
    let cardHeight: CGFloat = 280
    let cardHandleAreaLength: CGFloat = 65
    var apiResult: LegsWrapperModel? = nil
    var polyline: GMSPolyline? = nil
    
    var cardVisible = false
    var nextState: CardState {
        return cardVisible ? .collapsed : .expanded
    }
    
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted: CGFloat = 0
    
    var mapView: GMSMapView?
    
    @IBOutlet weak var goingToWorkSwitch: UISwitch!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var switchView: UIView!
    @IBOutlet weak var buttonStackView: UIStackView!
    
    @IBAction func gottaGoButton(_ sender: Any) {
        activityIndicator.isHidden = false
        polyline?.map = nil
        if userHasEnteredData() {
            formatDate()
            apiResult = googleAPI.getNavigation(goingToWork: goingToWorkSwitch.isOn)
            guard let apiResult = apiResult else {
                showOKMessage(title: "An Error Occurred", message: "We were unable to process your request!")
                return
            }
            setupMapAfterPress()
            formatDepartureTimes(with: apiResult)
            NotificationManager.createNotification()
        } else {
            showOKMessage(title: "You haven't entered your Commute details", message: "Tap the settings button to enter in your details.")
        }
    }
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        goToSettingsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        setupInterationLayers()
        setupCard()
        requestForNotificationPermissions()
    }
    
    func requestForNotificationPermissions() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound], completionHandler: { granted, error in })
    }
    
    func userHasEnteredData() -> Bool {
        if let home = propertyKey.userDefaults.string(forKey: "homeAddress"), let work = propertyKey.userDefaults.string(forKey: "workAddress"), home != "" && work != "" {
            return true
        }
        return false
    }
    
    func setupInterationLayers() {
        switchView.layer.cornerRadius = 8
        buttonStackView.arrangedSubviews.first?.clipsToBounds = true
        buttonStackView.arrangedSubviews.first?.layer.cornerRadius = 10
        buttonStackView.arrangedSubviews.first?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        buttonStackView.arrangedSubviews[1].clipsToBounds = true
        buttonStackView.arrangedSubviews[1].layer.cornerRadius = 10
        buttonStackView.arrangedSubviews[1].layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
    }
    
    func formatDate() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "Your date Format"
        let departHomeTime = Date(timeIntervalSince1970: TimeInterval(propertyKey.userDefaults.integer(forKey: "homeTimePicker")))
        let departWorkTime = Date(timeIntervalSince1970: TimeInterval(propertyKey.userDefaults.integer(forKey: "workTimePicker")))
        let calendar = Calendar.current
        let departHomeComp = calendar.dateComponents([.hour, .minute], from: departHomeTime)
        let departWorkComp = calendar.dateComponents([.hour, .minute], from: departWorkTime)
        
        let currentDate = Date()
        let currentCalendar = Calendar.current
        
        var dateComponentsForHome = DateComponents()
        dateComponentsForHome.year = currentCalendar.component(.year, from: currentDate)
        dateComponentsForHome.month = currentCalendar.component(.month, from: currentDate)
        dateComponentsForHome.day = currentCalendar.component(.day, from: currentDate)
        dateComponentsForHome.hour = departHomeComp.hour
        dateComponentsForHome.minute = departHomeComp.minute
        
        var dateComponentsForWork = DateComponents()
        dateComponentsForWork.year = currentCalendar.component(.year, from: currentDate)
        dateComponentsForWork.month = currentCalendar.component(.month, from: currentDate)
        dateComponentsForWork.day = currentCalendar.component(.day, from: currentDate)
        dateComponentsForWork.hour = departWorkComp.hour
        dateComponentsForWork.minute = departWorkComp.minute
        
        // Create date from components
        let userCalendar = Calendar.current // user calendar
        let finalDepartHomeDate = userCalendar.date(from: dateComponentsForHome)
        let finalDepartWorkDate = userCalendar.date(from: dateComponentsForWork)
        
        propertyKey.userDefaults.set(finalDepartHomeDate?.timeIntervalSince1970, forKey: "homeTimePicker")
        propertyKey.userDefaults.set(finalDepartWorkDate?.timeIntervalSince1970, forKey: "workTimePicker")
        
    }
    
    func setupMap() {
        activityIndicator.isHidden = true
        
        let lat = propertyKey.userDefaults.double(forKey: "defaultStartLat")
        let long = propertyKey.userDefaults.double(forKey: "defaultStartLng")
 
        let camera = lat != 0 && long != 0 ? GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 10.0) : GMSCameraPosition.camera(withLatitude: 37.621262, longitude: -122.378945, zoom: 10.0)
        mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        
        guard let mapView = mapView else {
            return
        }
        view.addSubview(mapView)
        
        do {
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        
        view.sendSubview(toBack: mapView)
    }
    
    func setupMapAfterPress() {
        animateTransitionIfNeeded(state: nextState, duration: 0.9)
        resultScreenCardController.departureTimeLabel.text = propertyKey.userDefaults.string(forKey: "defaultDepartureTime")
        resultScreenCardController.arrivalTimeLabel.text = propertyKey.userDefaults.string(forKey: "defaultArrivalTime")
        resultScreenCardController.durationTimeLabel.text = propertyKey.userDefaults.string(forKey: "defaultDuration")
        resultScreenCardController.tutorialView.isHidden = true
        
        if goingToWorkSwitch.isOn {
            resultScreenCardController.departureTextLabel.text = "Departure time from Home"
            resultScreenCardController.arrivalTextLabel.text = "Arrival time at Work"
        } else {
            resultScreenCardController.departureTextLabel.text = "Departure time from Work"
            resultScreenCardController.arrivalTextLabel.text = "Arrival time at Home"

        }
        
        let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: propertyKey.userDefaults.double(forKey: "defaultStartLat")) ?? 0, longitude: CLLocationDegrees(exactly: propertyKey.userDefaults.double(forKey: "defaultStartLng")) ?? 0)
        
        self.mapView?.animate(toLocation: coordinate)
        self.mapView?.animate(toZoom: 12)
        
        let path = GMSPath(fromEncodedPath: propertyKey.userDefaults.string(forKey: "defaultPolyline")!)
        polyline = GMSPolyline(path: path)
        guard let polyline = polyline else { return }
        polyline.strokeWidth = 3.0
        polyline.strokeColor = UIColor(red:0.00, green:0.63, blue:0.06, alpha:1.0)
        
        polyline.map = mapView
    }
    
    func formatDepartureTimes(with model: LegsWrapperModel) {
        let departureTimeString = model.routes[0].legs[0].departure_time.text
        let formattedDepartureTime = getTimeFromString(called: departureTimeString)
        propertyKey.userDefaults.set(formattedDepartureTime.0, forKey: "departureHour")
        propertyKey.userDefaults.set(formattedDepartureTime.1, forKey: "departureMinute")
    }
    
    func setupCard() {
        resultScreenCardController = ResultScreenViewController(nibName: "ResultScreenViewController", bundle: nil)
        self.addChildViewController(resultScreenCardController)
        self.view.addSubview(resultScreenCardController.view)
        
        resultScreenCardController.handleView.layer.cornerRadius = 7
        
        resultScreenCardController.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaLength, width: self.view.bounds.width, height: cardHeight)
        
        resultScreenCardController.view.clipsToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.handleCardTap))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(HomeViewController.handleCardPan))
        
        resultScreenCardController.view.layer.cornerRadius = 30
        resultScreenCardController.view.backgroundColor = UIColor(red:0.00, green:0.63, blue:0.06, alpha:1.0)
        
        resultScreenCardController.tabView.addGestureRecognizer(tapGestureRecognizer)
        resultScreenCardController.tabView.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc func handleCardTap(recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            animateTransitionIfNeeded(state: nextState, duration: 0.9)
        default:
            break
        }
    }
    
    @objc func handleCardPan(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInteractiveTransition(state: nextState, duration: 0.9)
        case .changed:
            let translation = recognizer.translation(in: self.resultScreenCardController.tabView)
            var fractionComplete = translation.y/cardHeight
            fractionComplete = cardVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition()
        default:
            break
        }
    }
    
    func animateTransitionIfNeeded (state: CardState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1, animations: {
                switch state {
                case .expanded:
                    self.resultScreenCardController.view.frame.origin.y = self.view.frame.height - self.cardHeight
                case .collapsed:
                    self.resultScreenCardController.view.frame.origin.y = self.view.frame.height - self.cardHandleAreaLength
                }
            })
            
            frameAnimator.addCompletion({ _ in
                self.cardVisible = !self.cardVisible
                self.runningAnimations.removeAll()
            })
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
        }
    }
    
    func startInteractiveTransition (state: CardState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    func updateInteractiveTransition(fractionCompleted: CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    
    func continueInteractiveTransition() {
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func goToSettingsView() {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = true
            
            let storyBoard = UIStoryboard(name: "SettingsView", bundle: nil)
            let settingsViewController = storyBoard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
            self.navigationController?.pushViewController(settingsViewController, animated: true)
        }
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

