//
//  StartAddressModel.swift
//  GottaGo
//
//  Created by Dhruv Mathur on 2019-02-05.
//  Copyright © 2019 Dhruv Mathur (LCL). All rights reserved.
//

import Foundation

class StartAddressModel: Decodable {
    let lat: Double
    let lng: Double
    
    init(json: [String:Any]) {
        lat = json["lat"] as? Double ?? 0.0
        lng = json["lng"] as? Double ?? 0.0
    }
}
