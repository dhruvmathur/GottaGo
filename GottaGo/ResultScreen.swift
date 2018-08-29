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
        
        // Do any additional setup after loading the view, typically from a nib.
        
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: 48.857165, longitude: 2.354613, zoom: 8.0)
        mapView.camera = camera

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


