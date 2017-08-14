//
//  ProductCell.swift
//  ShoppingApp
//
//  Created by Sinisa Vukovic on 09/08/2017.
//  Copyright © 2017 Sinisa Vukovic. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {

//MARK: IBOutlets
   @IBOutlet weak var cellImageView: RoundedImageView!
   @IBOutlet weak var basketImageView: UIImageView!
   @IBOutlet weak var priceLabel: UILabel!
   @IBOutlet weak var nameLabel: UILabel!
   
//MARK: Property
   public var product:Product?

//MARK: UITableViewCell methods
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      if selected {
         basketImageView.image = UIImage(named: "emptyBasket")
      }else {
         basketImageView.image = UIImage(named: "basket")
      }
    }
   
//MARK: Private methods
   func configureCell(with product: Product) {
      self.product = product
      if let image = UIImage(named: product.name) {
         cellImageView.image = image
         let formatedString = String(format: "%.2f", product.price)
         priceLabel.text = "\(formatedString) \(product.currency?.name ?? "USD")"
         nameLabel.text = product.name
      }
   }
}
