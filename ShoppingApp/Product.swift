//
//  ProductModel.swift
//  ShoppingApp
//
//  Created by Sinisa Vukovic on 09/08/2017.
//  Copyright © 2017 Sinisa Vukovic. All rights reserved.
//

import Foundation

class Product {
   
   private var _name:String
   private var _valueIn$:Double
   private var _price: Double
   private var _currency:Currency?
   
   var name:String {
      return _name
   }
   
   var price:Double {
      return _price.roundTo(places: 2)
   }
   
   var valueIn$:Double {
      return _valueIn$
   }
   
   var currency:Currency? {
      return _currency != nil ? _currency : nil
   }
   
   public func setPrice(with currency:Currency) {
      self._currency = currency
      self._price = _valueIn$ * currency.exchangeRate
   }
   
   init(name:String, price:Double) {
      self._name = name
      self._valueIn$ = price
      self._price = price
   }
}
