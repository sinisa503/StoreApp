
//
//  NetworkServiceMock.swift
//  ShoppingApp
//
//  Created by Sinisa Vukovic on 14/08/2017.
//  Copyright © 2017 Sinisa Vukovic. All rights reserved.
//

import Foundation
@testable import ShoppingApp

/** Mock object for mocking fetching currencies from cloud **/
class DataServiceMock: DataServiceProtocol {
   
   public lazy var mockCurrencies:[Currency] = {
      var array:[Currency] = []
      for i in 0...10 {
         let testCurrency = Currency(name: "testCurrency\(i)", exchangeRate: 0.0 + 1)
         array.append(testCurrency)
      }
      return array
   }()
   
   func getCurrenciesRates(_success: @escaping ([Currency]) -> Void, _failure: @escaping (NetworkError) -> Void) {
      
      _success(mockCurrencies)
   }
   
}
