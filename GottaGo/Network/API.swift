//
//  API.swift
//  GottaGo
//
//  Created by Dhruv Mathur on 2018-05-02.
//  Copyright © 2018 Dhruv Mathur (LCL). All rights reserved.
//

import Foundation
import Alamofire

class API{
    
    static let baseURL = "https://maps.googleapis.com/maps/api/directions/json?"
    static var mode = "mode=transit"
    static var key = "key=AIzaSyB5DcPrOlDnsunE9Y7l-8o_61WA4BhFp1Q"
    //var departure_time = "departure_time=\()"
    
    func getNavigation(goingToWork: Bool) -> LegsWrapperModel {
        let url = URL(string: createURL(goingToWork: goingToWork))
        var navigationModel: LegsWrapperModel = LegsWrapperModel(json: [:])
        URLSession.shared.dataTask(with: url ?? URL(string: "")!) { (data, response, err) in
                guard let data = data else { return }
                do {
                    let navigation = try JSONDecoder().decode(LegsWrapperModel.self, from: data)
                    navigationModel = navigation
                    let data = navigation.routes[0].legs[0]
                    
                    if data.arrival_time.text != "" {
                        navigationModel = navigation
                        propertyKey.userDefaults.set(data.arrival_time.text, forKey: "defaultArrivalTime")
                        propertyKey.userDefaults.set(data.departure_time.text, forKey: "defaultDepartureTime")
                        propertyKey.userDefaults.set(data.duration.text, forKey: "defaultDuration")
                        propertyKey.userDefaults.set(data.start_location.lat, forKey: "defaultStartLat")
                        propertyKey.userDefaults.set(data.start_location.lng, forKey: "defaultStartLng")
                        propertyKey.userDefaults.set(navigation.routes[0].overview_polyline.points, forKey: "defaultPolyline")
                        NotificationCenter.default.post(NSNotification(name: NSNotification.Name(rawValue: "segue"), object: nil) as Notification)
                    }

                } catch let jsonErr {
                    print("Error serializing json:", jsonErr)
                }
                }.resume()
        
        return navigationModel
    }
    
    func createURL(goingToWork: Bool) -> String {
        let arrival_time: String
        let home = "origin=\(propertyKey.userDefaults.string(forKey: "homeAddress")!)"
        let work = "destination=\(propertyKey.userDefaults.string(forKey: "workAddress")!)"
        var originformatted: String
        var destinationformatted: String
        if goingToWork {
            arrival_time = "arrival_time=\(propertyKey.userDefaults.integer(forKey: "workTimePicker"))"
            originformatted = home.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
            destinationformatted = work.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        } else {
            arrival_time = "arrival_time=\(propertyKey.userDefaults.integer(forKey: "homeTimePicker"))"
            originformatted = work.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
            destinationformatted = home.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        }
        
        let parameters = "\(originformatted)&\(destinationformatted)&\(API.mode)&\(arrival_time)&\(API.key)"
        let finalURLInString = API.baseURL + parameters
        
        return finalURLInString

    }
    
}
