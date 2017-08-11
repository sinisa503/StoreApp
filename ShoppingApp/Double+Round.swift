//
//  Double+Round.swift
//  ShoppingApp
//
//  Created by Sinisa Vukovic on 10/08/2017.
//  Copyright © 2017 Sinisa Vukovic. All rights reserved.
//

import Foundation

extension Double {
   
   /// Rounds the double to decimal places value
   func roundTo(places:Int) -> Double {
      let divisor = pow(10.0, Double(places))
      return (self * divisor).rounded() / divisor
   }
}
