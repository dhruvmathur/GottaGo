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
    static var origin = "origin=\(propertyKey.userDefaults.string(forKey: "homeAddress")!)"
    static var destination = "destination=\(propertyKey.userDefaults.string(forKey: "workAddress")!)"
    static var mode = "mode=transit"
    static var key = "key=AIzaSyB5DcPrOlDnsunE9Y7l-8o_61WA4BhFp1Q"
    //var departure_time = "departure_time=\()"
    static var arrival_time = "arrival_time=\(propertyKey.userDefaults.integer(forKey: "workTimePicker"))"
    
    func makeURL() {
        let  originformatted = API.origin.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        let  destinationformatted = API.destination.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        let parameters = "\(originformatted)&\(destinationformatted)&\(API.mode)&\(API.arrival_time)&\(API.key)"
        let finalURLInString = API.baseURL + parameters
        print(finalURLInString)
        // let requestURL: URL = URL(string: API.baseURL+parameters)!
        
        Alamofire.request(finalURLInString, method: .get, parameters: ["":""], encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    print(response.result.value!)
                }
                break
            case .failure(_):
                print(response.result.error!)
                break
            }
        }
    }
}
