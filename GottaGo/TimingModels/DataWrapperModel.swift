//
//  DataWrapperModel.swift
//  GottaGo
//
//  Created by Dhruv Mathur on 2019-02-04.
//  Copyright © 2019 Dhruv Mathur (LCL). All rights reserved.
//

import Foundation

class DataWrapperModel: Decodable {
    let arrival_time: ArrivalTimeModel
    let departure_time: DepartureTimeModel
    let duration: DurationModel
    let start_location: StartAddressModel
    
    init(json: [String:Any]) {
        arrival_time = json["arrival_time"] as? ArrivalTimeModel ?? ArrivalTimeModel(json: [:])
        departure_time = json["departure_time"] as? DepartureTimeModel ?? DepartureTimeModel(json: [:])
        duration = json["duration"] as? DurationModel ?? DurationModel(json: [:])
        start_location = json["start_location"] as? StartAddressModel ?? StartAddressModel(json: [:])
    }
}
