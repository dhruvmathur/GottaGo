//
//  Extensions.swift
//  GottaGo
//
//  Created by Dhruv Mathur on 2019-06-03.
//  Copyright © 2019 Dhruv Mathur (LCL). All rights reserved.
//

import Foundation

func getMapStyling() -> String? {
    do {
        if let path = Bundle.main.path(forResource: "style", ofType: "json") {
            let json = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
            let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
            return convertedString
        }
        return nil
    } catch let myJSONError {
        print(myJSONError)
        return nil
    }
}

func getTimeFromString(called string: String) -> (Int, Int) {
    let dateFormatter = DateFormatter()
    let text = string.replacingOccurrences(of: ".", with: "", options: NSString.CompareOptions.literal, range: nil)
    dateFormatter.dateFormat = "h:mma"
    let date = dateFormatter.date(from: text)
    
    dateFormatter.dateFormat = "HH:mm"
    let secondDateString = dateFormatter.string(from: date!)
    let date2 = dateFormatter.date(from: secondDateString)
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: date2!)
    let minutes = calendar.component(.minute, from: date2!)
    return (hour, minutes)
}


