//
//  NetworkServiceUnitTest.swift
//  ShoppingApp
//
//  Created by Sinisa Vukovic on 14/08/2017.
//  Copyright © 2017 Sinisa Vukovic. All rights reserved.
//

import XCTest
@testable import ShoppingApp

class DataServiceUnitTest: XCTestCase {
   
   private var dataService:DataServiceProtocol?
    
    override func setUp() {
        super.setUp()
      
      dataService = DataServiceMock()
    }
    
    override func tearDown() {
        dataService = nil
        super.tearDown()
    }
    
    func testDataServideDownload() {
      let expecation = expectation(description: "Expected load currencies from cloud")
      dataService?.getCurrenciesRates(_success: { (currencies) in
         expecation.fulfill()
         XCTAssertNotNil(currencies)
         XCTAssertEqual(currencies.count, 11)
      }, _failure: { (networkError) in
         XCTAssertNotNil(networkError)
         XCTFail()
      })
      waitForExpectations(timeout: 0.1, handler: nil)
    }
}
