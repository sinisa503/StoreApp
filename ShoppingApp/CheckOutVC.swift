//
//  CheckOutVCViewController.swift
//  ShoppingApp
//
//  Created by Sinisa Vukovic on 13/08/2017.
//  Copyright © 2017 Sinisa Vukovic. All rights reserved.
//

import UIKit

protocol ResetProtocol {
   func resetAll()
}

class CheckOutVC: UIViewController, FinalPriceProtocol{
   
   @IBOutlet weak var table:UITableView!
   
   internal var selectedProducts:[Product]?
   internal let cellIdentifier = "SelectedProductCellidentifier"
   private let cellNibName = "SelectedProductCell"
   private let controllerIdentifier = "CheckOutVC"
   private var payButton:UIBarButtonItem?
   var delegate: ResetProtocol?
   
   var allProductsPrices: [String : Double] = [:]{
      didSet {
         var finalPrice = 0.0
         for price in allProductsPrices {
            finalPrice += price.value
         }
         let formatedString = String(format: "%.2f", finalPrice)
         payButton?.title = "\(formatedString) \(selectedProducts?.first?.currency?.name ?? "USD")"
      }
   }
   
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
   }
   
   init(selectedProducts: [Product]) {
      self.selectedProducts = selectedProducts
      super.init(nibName: controllerIdentifier, bundle: nil)
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      payButton = UIBarButtonItem(title: "0.0", style: .plain, target: self, action: #selector(payForTheProducts(barButton:)))
      let selPrCell = UINib(nibName: cellNibName, bundle: nil)
      table.register(selPrCell, forCellReuseIdentifier: cellIdentifier)
      self.title = "Products"
      self.navigationItem.rightBarButtonItem = payButton
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      if let selectedProducts = selectedProducts {
         for product in selectedProducts {
            allProductsPrices[product.name] = product.price
         }
      }
   }
   
   @objc
   func payForTheProducts(barButton: UIBarButtonItem) {
      let alert = UIAlertController(title: "Payment", message: "Authorize you payment", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
      
      alert.addAction(UIAlertAction(title: "Pay", style: .default){[weak self](action) in
         let thanksAlert = UIAlertController(title: "Thank you", message: "Your items will be deliverd within two hours", preferredStyle: .alert)
         thanksAlert.addAction(UIAlertAction(title: "OK", style: .default){[weak self] (_) in
            if self?.delegate != nil {
               self?.delegate?.resetAll()
            }
            self?.navigationController?.popViewController(animated: true)
         })
         self?.present(thanksAlert, animated: true, completion: nil)
         }
      )
      
      present(alert, animated: true, completion: nil)
   }
}


extension CheckOutVC: UITableViewDelegate, UITableViewDataSource {
   
   func numberOfSections(in tableView: UITableView) -> Int {
      return 1
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return selectedProducts?.count ?? 0
   }
   
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as?
         SelectedProductCell {
         guard let selectedProducts = selectedProducts else { return UITableViewCell() }
         cell.delegate = self
         cell.configure(with: selectedProducts[indexPath.row])
         return cell
      }else {
         return UITableViewCell()
      }
   }
}
