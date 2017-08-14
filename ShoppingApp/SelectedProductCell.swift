//
//  SelectedProductCellTableViewCell.swift
//  ShoppingApp
//
//  Created by Sinisa Vukovic on 13/08/2017.
//  Copyright © 2017 Sinisa Vukovic. All rights reserved.
//

import UIKit

protocol FinalPriceProtocol {
   var allProductsPrices:[String:Double]{get set}
}

class SelectedProductCell: UITableViewCell {
   
   @IBOutlet weak var cellImageView: RoundedImageView!
   @IBOutlet weak var priceLabel: UILabel!
   @IBOutlet weak var nameLabel: UILabel!
   @IBOutlet weak var numberPicker: UIPickerView!
   
   internal let numberPickerDataSource:[Int] = [1,2,3,4,5,6,7,8,9,10]
   internal var product:Product?
   internal var delegate:FinalPriceProtocol?
   
   internal var totalPrice:Double = 0 {
      didSet {
         delegate?.allProductsPrices[(product?.name)!] = totalPrice
      }
   }
   
    override func awakeFromNib() {
        super.awakeFromNib()
      
      numberPicker.dataSource = self
      numberPicker.delegate = self
    }

   func configure(with product:Product) {
      self.product = product
      cellImageView.image = UIImage(named: product.name)
      nameLabel.text = product.name
      totalPrice = product.price
      let formatedString = String(format: "%.2f", product.price)
      priceLabel.text = "\(formatedString) \(product.currency?.name ?? "USD")"
   }
   
}


extension SelectedProductCell: UIPickerViewDelegate, UIPickerViewDataSource {
   
   func numberOfComponents(in pickerView: UIPickerView) -> Int {
      return 1
   }
   
   func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      return numberPickerDataSource.count
   }
   
   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      return String(numberPickerDataSource[row])
   }
   
   func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      let numberOfItems = row + 1
      totalPrice = (product?.price)! * Double(numberOfItems)
      let formatedString = String(format: "%.2f", totalPrice)
      priceLabel.text = "\(formatedString) \(product?.currency?.name ?? "USD")"
   }
}
