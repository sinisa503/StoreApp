//
//  Currency.swift
//  ShoppingApp
//
//  Created by Sinisa Vukovic on 10/08/2017.
//  Copyright © 2017 Sinisa Vukovic. All rights reserved.
//

import Foundation

class Currency {
   
   private var _name:String
   private var _exchangeRate: Double
   
   public var name:String {
      return _name
   }
   
   public var exchangeRate:Double {
      return _exchangeRate
   }
   
   public init (name: String, exchangeRate: Double) {
      self._name = name
      self._exchangeRate = exchangeRate
   }
}
