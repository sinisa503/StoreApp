//
//  ProductModelTests.swift
//  ShoppingApp
//
//  Created by Sinisa Vukovic on 14/08/2017.
//  Copyright © 2017 Sinisa Vukovic. All rights reserved.
//

import XCTest
@testable import ShoppingApp

class ProductModelTests: XCTestCase {
   
   private var testCurrency:Currency? = nil
   private var secondTestCurrency:Currency? = nil
   private var testProduct:Product? = nil
   private let TEST_PRODUCT_NAME = "testProduct"
   private let TEST_PRODUCT_PRICE = 12.32
   private let TEST_CURRENCY_NAME = "TST"
   private let TEST_CURRENCY_RATE = 2.5
   private let SECOND_TEST_CURRENCY_NAME = "TST_2"
   private let SECOND_TEST_CURRENCY_RATE = 10.5
   
   override func setUp() {
      super.setUp()
      
      testCurrency = Currency(name: TEST_CURRENCY_NAME, exchangeRate: TEST_CURRENCY_RATE)
      secondTestCurrency = Currency(name: SECOND_TEST_CURRENCY_NAME, exchangeRate: SECOND_TEST_CURRENCY_RATE)
      testProduct = Product(name: TEST_PRODUCT_NAME, price: TEST_PRODUCT_PRICE)
   }
   
   override func tearDown() {
      testProduct = nil
      testCurrency = nil
      super.tearDown()
   }
   
   func testProductModelCreation() {
      XCTAssertNil(testProduct?.currency)
      XCTAssertNotNil(testProduct?.name)
      XCTAssertNotNil(testProduct?.price)
      XCTAssertNotNil(testProduct?.valueIn$)
      XCTAssertEqual(testProduct?.price, testProduct?.valueIn$)
   }
   
   func testProductSetPriceWithCurrency (){
      testProduct?.setPrice(with: secondTestCurrency!)
      XCTAssertNotNil(testProduct?.currency)
      XCTAssertEqual(testProduct?.price, (testProduct?.valueIn$)! * (testProduct?.currency?.exchangeRate)!)
   }
}
