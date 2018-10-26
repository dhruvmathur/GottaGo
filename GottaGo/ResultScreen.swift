//
//  ResultScreen.swift
//  GottaGo
//
//  Created by Dhruv Mathur on 2018-05-02.
//  Copyright © 2018 Dhruv Mathur (LCL). All rights reserved.
//

import UIKit
import GoogleMaps

class ResultScreen: UIViewController{

    @IBOutlet weak var departureLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var arrivalLabel: UILabel!
    
    @IBOutlet weak var durationTimeLabel: UILabel!
    @IBOutlet weak var departureTimeLabel: UILabel!
    @IBOutlet weak var arrivalTimeLabel: UILabel!
    
    @IBOutlet weak var mapView: GMSMapView!
    
//    override func loadView() {
//        // Create a GMSCameraPosition that tells the map to display the
//        // coordinate -33.86,151.20 at zoom level 6.
//        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
//        let mapFrame = CGRect(origin: CGPoint(x: 10,y :10), size: CGSize(width: 100, height: 100))
//        let mapView = GMSMapView.map(withFrame: mapFrame, camera: camera)
//        //self.view.addSubview(mapView)
//        view.addSubview(mapView)
//
//        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = mapView
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        durationTimeLabel.text = propertyKey.userDefaults.string(forKey: "defaultDepartureTime")
        arrivalTimeLabel.text = propertyKey.userDefaults.string(forKey: "defaultArrivalTime")
        departureTimeLabel.text = propertyKey.userDefaults.string(forKey: "defaultDuration")
        
        durationTimeLabel.isHidden = false
        arrivalTimeLabel.isHidden = false
        departureTimeLabel.isHidden = false
        
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: 43.6532, longitude: -79.3832, zoom: 8)
        mapView.camera = camera
        
        let path = GMSPath(fromEncodedPath: propertyKey.userDefaults.string(forKey: "defaultPolyline")!)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 3.0
        polyline.strokeColor = UIColor.red
        polyline.map = mapView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


