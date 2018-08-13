//
//  GottaGoUITests.swift
//  GottaGoUITests
//
//  Created by Dhruv Mathur (LCL) on 3/21/18.
//  Copyright © 2018 Dhruv Mathur (LCL). All rights reserved.
//

import XCTest

class GottaGoUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        let app = XCUIApplication()
        let settingsNavigationBar = app.navigationBars["Settings"]
        let saveButton = settingsNavigationBar.buttons["Save"]
        let settingsButton = app.buttons["Settings"]
        settingsButton.tap()
        //saveButton.tap()
        
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.textFields["Home Address"].tap()
        elementsQuery.textFields["Home Address"].typeText("12 Hickory Ridge Court, Brampton")
        
        let workAddressTextField = elementsQuery.textFields["Work Address"]
        workAddressTextField.tap()
        workAddressTextField.typeText("UWP, Waterloo")
        saveButton.tap()
        saveButton.tap()
        settingsNavigationBar.buttons["Back"].tap()
        app.buttons["GottaGo!"].tap()
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
