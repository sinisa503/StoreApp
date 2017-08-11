//
//  GradientedView.swift
//  ShoppingApp
//
//  Created by Sinisa Vukovic on 09/08/2017.
//  Copyright © 2017 Sinisa Vukovic. All rights reserved.
//

import UIKit

@IBDesignable
open class GradientView: UIView {
   @IBInspectable
   public var startColor: UIColor = .white {
      didSet {
         gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
         setNeedsDisplay()
      }
   }
   @IBInspectable
   public var endColor: UIColor = .white {
      didSet {
         gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
         setNeedsDisplay()
      }
   }
   
   private lazy var gradientLayer: CAGradientLayer = {
      let gradientLayer = CAGradientLayer()
      gradientLayer.frame = self.bounds
      gradientLayer.colors = [self.startColor.cgColor, self.endColor.cgColor]
      return gradientLayer
   }()
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      layer.insertSublayer(gradientLayer, at: 0)
   }
   
   public required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      layer.insertSublayer(gradientLayer, at: 0)
   }
   
   open override func layoutSubviews() {
      gradientLayer.frame = bounds
   }
}
