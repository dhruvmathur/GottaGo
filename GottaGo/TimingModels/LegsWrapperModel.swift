//
//  LegsWrapperModel.swift
//  GottaGo
//
//  Created by Dhruv Mathur on 2019-02-04.
//  Copyright © 2019 Dhruv Mathur (LCL). All rights reserved.
//

import Foundation

class LegsWrapperModel: Decodable {
    let routes: [RoutesModel]
    let status: String
    let error: String? = nil
    
    init(json: [String:Any]) {
        routes = json["routes"] as? [RoutesModel] ?? [RoutesModel(json: [:])]
        status = json["status"] as? String ?? ""
    }
}
