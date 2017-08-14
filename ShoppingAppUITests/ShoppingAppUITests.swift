//
//  ShoppingAppUITests.swift
//  ShoppingAppUITests
//
//  Created by Sinisa Vukovic on 09/08/2017.
//  Copyright © 2017 Sinisa Vukovic. All rights reserved.
//

import XCTest
@testable import ShoppingApp

class ShoppingAppUITests: XCTestCase {
   
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
   
   func testSelectingProductsAndCheckout() {
      let app = XCUIApplication()
      let tablesQuery = app.tables
      tablesQuery.staticTexts["0.73 USD"].tap()
      tablesQuery.staticTexts["1.30 USD"].tap()
      tablesQuery.staticTexts["0.95 USD"].tap()
      tablesQuery.staticTexts["2.10 USD"].tap()
      app.navigationBars["Store"].buttons["5.08 USD"].tap()
      app.navigationBars["Products"].buttons["5.08 USD"].tap()
      app.alerts["Payment"].buttons["Pay"].tap()
      app.alerts["Thank you"].buttons["OK"].tap()
    }
    
}
