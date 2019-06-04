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
