//
//  OverPolylineModel.swift
//  GottaGo
//
//  Created by Dhruv Mathur on 2019-02-03.
//  Copyright © 2019 Dhruv Mathur (LCL). All rights reserved.
//

import Foundation

class OverPolylineModel: Decodable {
    let points: String
    
    init(json: [String:Any]) {
        points = json["points"] as? String ?? ""
    }
}
