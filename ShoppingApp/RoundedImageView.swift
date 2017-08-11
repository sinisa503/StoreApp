//
//  RoundedImageView.swift
//  ShoppingApp
//
//  Created by Sinisa Vukovic on 09/08/2017.
//  Copyright © 2017 Sinisa Vukovic. All rights reserved.
//

import UIKit

class RoundedImageView: UIImageView {
   
   override func layoutSubviews() {
      super.layoutSubviews()
      
      layer.cornerRadius = 10
      clipsToBounds = true
   }

}
