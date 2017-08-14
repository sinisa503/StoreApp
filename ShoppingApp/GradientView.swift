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
   
//MARK: IBInspectable properties
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

//MARK: Gradient Layer
   private lazy var gradientLayer: CAGradientLayer = {
      let gradientLayer = CAGradientLayer()
      gradientLayer.frame = self.bounds
      gradientLayer.colors = [self.startColor.cgColor, self.endColor.cgColor]
      return gradientLayer
   }()
   
//MARK: Initialization
   override init(frame: CGRect) {
      super.init(frame: frame)
      layer.insertSublayer(gradientLayer, at: 0)
   }
   
   public required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      layer.insertSublayer(gradientLayer, at: 0)
   }
   
//MARK: UIView lifecycle methods
   open override func layoutSubviews() {
      gradientLayer.frame = bounds
   }
}
