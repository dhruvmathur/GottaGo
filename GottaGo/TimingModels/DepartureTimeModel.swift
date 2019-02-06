//
//  DepartureTimeModel.swift
//  GottaGo
//
//  Created by Dhruv Mathur on 2019-02-03.
//  Copyright © 2019 Dhruv Mathur (LCL). All rights reserved.
//

import Foundation

class DepartureTimeModel: Decodable {
    let text: String
    
    init(json: [String:Any]) {
        text = json["text"] as? String ?? ""
    }
}
