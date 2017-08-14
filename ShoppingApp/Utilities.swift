//
//  Utilities.swift
//  ShoppingApp
//
//  Created by Sinisa Vukovic on 10/08/2017.
//  Copyright © 2017 Sinisa Vukovic. All rights reserved.
//

import Foundation

class Utilities {

   public static func removeUSDPrefix(currency: String) -> String {
      let prefixedString = currency
      if prefixedString.contains("USD") {
         let startIndex = prefixedString.index(prefixedString.startIndex , offsetBy: 3)
         return prefixedString.substring(from: startIndex)
      }
      return prefixedString
   }
}
