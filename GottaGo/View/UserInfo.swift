//
//  UserInfo.swift
//  GottaGo
//
//  Created by Dhruv Mathur on 2018-05-02.
//  Copyright © 2018 Dhruv Mathur (LCL). All rights reserved.
//

import Foundation



class propertyKey {
    static let userDefaults: UserDefaults = .standard
    
    static var savedHomeAddress: String = ""
    static var savedWorkAddress: String = ""
    static var timeToGetToWork: Int = 0
    static var timeToLeaveHome: Int = 0
}

