//
//  RoutesModel.swift
//  GottaGo
//
//  Created by Dhruv Mathur on 2019-02-04.
//  Copyright © 2019 Dhruv Mathur (LCL). All rights reserved.
//

import Foundation

class RoutesModel: Decodable {
    let legs: [DataWrapperModel]
    let overview_polyline: OverPolylineModel
    
    init(json: [String:Any]) {
        legs = json["legs"] as? [DataWrapperModel] ?? [DataWrapperModel(json: [:])]
        overview_polyline = json["overview_polyline"] as? OverPolylineModel ?? OverPolylineModel(json: [:])
    }
}
