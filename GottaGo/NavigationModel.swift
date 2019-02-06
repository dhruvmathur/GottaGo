//
//  NavigationModel.swift
//  GottaGo
//
//  Created by Dhruv Mathur on 2019-02-03.
//  Copyright © 2019 Dhruv Mathur (LCL). All rights reserved.
//

import Foundation

class NavigationModel: Decodable {
    let id: Int
    let title: String
    let body_html: String
    let vendor: String
    let product_type: String
    
    init(json: [String:Any]) {
        id = json["id"] as? Int ?? 0
        title = json["title"] as? String ?? ""
        body_html = json["body_html"] as? String ?? ""
        vendor = json["vendor"] as? String ?? ""
        product_type = json["product_type"] as? String ?? ""
    }
}
