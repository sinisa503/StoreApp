//
//  CheckOutTests.swift
//  ShoppingApp
//
//  Created by Sinisa Vukovic on 14/08/2017.
//  Copyright © 2017 Sinisa Vukovic. All rights reserved.
//

import XCTest
@testable import ShoppingApp

class CheckOutTests: XCTestCase {
   
   var selectedProducts:[Product]?
    override func setUp() {
        super.setUp()
      
      setSelectedProducts()
    }
    
    override func tearDown() {
        selectedProducts = nil
        super.tearDown()
    }
    
    func testGoToCheckOutVC() {
      let checkOutVC = CheckOutVC(selectedProducts: selectedProducts!)
      XCTAssertNotNil(checkOutVC.selectedProducts)
      XCTAssertNotNil(checkOutVC.allProductsPrices)
      XCTAssertEqual(checkOutVC.selectedProducts?.count, checkOutVC.allProductsPrices.count)
      
      for product in checkOutVC.selectedProducts! {
         if let productPrice = checkOutVC.allProductsPrices[product.name] {
          XCTAssertEqual(productPrice, product.price)
         }
      }
    }
   
   private func setSelectedProducts() {
      selectedProducts = []
      if selectedProducts == nil {
         for i in 1...5 {
            let selectedProduct = Product(name: "TestProductNo\(i)", price: Double(i))
            selectedProducts?.append(selectedProduct)
         }
      }
   }
}
