//
//  AsurionTestUITests.swift
//  AsurionTestUITests
//
//  Created by Camilo Cabana on 8/07/20.
//  Copyright © 2020 Camilo Cabana. All rights reserved.
//

import XCTest

class AsurionTestUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAlertMessages() {
        
        let app = XCUIApplication()
        app.launch()
        
        let officeHoursElement = app.tables.otherElements["Office Hours: M-F 9:00 - 18:00"]
        officeHoursElement.buttons["Chat"].press(forDuration: 3)
        
        let okButton = app.alerts["Message"].scrollViews.otherElements.buttons["Ok"]
        okButton.tap()
        officeHoursElement.buttons["Call"].tap()
        okButton.tap()
        
    }
    
    func testLoadAndNavigation() {
        
        let app = XCUIApplication()
        app.launch()
        
        let downloadCell = app.tables.staticTexts["Ferret"]
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: downloadCell, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Ferret"]/*[[".cells.staticTexts[\"Ferret\"]",".staticTexts[\"Ferret\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let downloadWeb = app.webViews.staticTexts["Ferret"]
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: downloadWeb, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        app.navigationBars["Ferret"].buttons["Home"].tap()
        
    }
}
