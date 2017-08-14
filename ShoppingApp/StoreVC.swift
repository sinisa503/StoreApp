//
//  MainVC.swift
//  ShoppingApp
//
//  Created by Sinisa Vukovic on 09/08/2017.
//  Copyright © 2017 Sinisa Vukovic. All rights reserved.
//

import UIKit

class StoreVC: UIViewController, ResetProtocol {

//MARK: IBOutlets
   @IBOutlet weak var tableView:UITableView!
   @IBOutlet weak var segmentedControlView: UIView!
   @IBOutlet weak var checkOutButton: UIBarButtonItem!
   
//MARK: IBAction
   @IBAction func checkOutPressed(_ sender: UIBarButtonItem) {
      let checkOutVC = CheckOutVC(selectedProducts: selectedProducts)
      checkOutVC.delegate = self
      navigationController?.pushViewController(checkOutVC, animated: true)
   }

//MARK: Properties
   private var productList:[String:Double] = ["Beans":0.73, "Eggs": 2.10, "Milk":1.30, "Peas": 0.95]
   private let dataService = DataService.shared
   internal var products:[Product] = []
   private var segmentedControl:UISegmentedControl?
   
   private var selectedCurrency:Currency? {
      didSet {
         var totalPrice = 0.00
         for product in selectedProducts {
            totalPrice = totalPrice + product.price
         }
         let formatedSum = String(format: "%.2f", totalPrice)
         totalSum = "\(formatedSum) \(selectedCurrency?.name ?? "USD")"
      }
   }
   
   internal var selectedProducts:[Product] = [] {
      didSet {
         var totalPrice = 0.00
         for product in selectedProducts {
            totalPrice = totalPrice + product.price
         }
         let formatedSum = String(format: "%.2f", totalPrice)
         totalSum = "\(formatedSum) \(selectedCurrency?.name ?? "USD")"
      }
   }
   
   private var totalSum:String = "0.00 USD" {
      didSet {
         checkOutButton.title = totalSum
      }
   }
   
   private var allCurrencies:[Currency]? {
      didSet {
         guard let allCurrencies = allCurrencies else { return }
         var allKeys:[String] = []
         for c in allCurrencies {
            allKeys.append(c.name)
         }
         DispatchQueue.main.sync {
            createSegmentedControll(with: allKeys)
         }
         for (index, c) in allCurrencies.enumerated() {
            DispatchQueue.main.sync {
               segmentedControl?.setTitle(c.name, forSegmentAt: index)
            }
            if c.name == "USD" {
               selectedCurrency = allCurrencies[index]
               segmentedControl?.selectedSegmentIndex = index
            }
         }
         segmentedControl?.addTarget(self, action: #selector(currencyChanged), for: .valueChanged)
      }
   }

//MARK: Controller lifecycle methods
   override func viewDidLoad() {
      super.viewDidLoad()
      
      loadProducts()
      loadCurrencies()
   }
   
   override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
      
      if let segmentedControl = segmentedControl {
         segmentedControlView.updateConstraints()
         segmentedControl.updateConstraints()
      }
   }
   
//MARK: Private methods
   private func loadProducts() {
      for identifier in productList {
         let productModel = Product(name: identifier.key, price: identifier.value)
         products.append(productModel)
      }
   }
   
   private func loadCurrencies () {
      dataService.getCurrenciesRates(_success: {[weak self] (currencyArray) in
         self?.allCurrencies = currencyArray
      }) {[weak self]  (error) in
         let alert = UIAlertController(title: "Error", message: "Error code: \(error.statusCode)", preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
         self?.present(alert, animated: true, completion: nil)
      }
   }
   
   @objc private func currencyChanged(segmentedControl: UISegmentedControl) {
      if let selectedCurrency = allCurrencies?[segmentedControl.selectedSegmentIndex] {
         print("Curr: \(selectedCurrency.name), rate: \(selectedCurrency.exchangeRate)")
         updatePrices(with: selectedCurrency)
         self.selectedCurrency = selectedCurrency
      }
   }
   
   private func createSegmentedControll(with allCurencyes: [String]) {
      let scWidth = 40
      segmentedControl = UISegmentedControl(items: allCurencyes)
      let scrollView = UIScrollView(frame: segmentedControlView.bounds)
      let segmentedControlFrame = CGRect(x: segmentedControlView.bounds.minX, y: segmentedControlView.bounds.minY , width: CGFloat(allCurencyes.count*scWidth) , height: segmentedControlView.bounds.height)
      segmentedControl?.frame = segmentedControlFrame
      scrollView.contentSize = CGSize(width: (segmentedControl?.frame.size.width)!, height: (segmentedControl?.frame.size.height)! - 1)
      scrollView.showsHorizontalScrollIndicator = false
      segmentedControl?.tintColor = UIColor.orange
      scrollView.addSubview(segmentedControl!)
      segmentedControlView.addSubview(scrollView)
   }
   
   
   private func updatePrices (with currency: Currency) {
      for product in products {
         product.setPrice(with: currency)
      }      
      guard let selectedRows =  tableView.indexPathsForSelectedRows else {
         tableView.reloadData()
         return
      }
      tableView.reloadData()
         for selectedRow in selectedRows {
            tableView.selectRow(at: selectedRow, animated: true, scrollPosition: UITableViewScrollPosition.none)
         }
   }

//MARK: Reset protocol method
   internal func resetAll() {
      guard let indexPaths = tableView.indexPathsForSelectedRows else { return }
      for indexPath in indexPaths {
         tableView.deselectRow(at: indexPath, animated: true)
      }
      selectedProducts = []
   }
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension StoreVC: UITableViewDataSource, UITableViewDelegate {
   
   func numberOfSections(in tableView: UITableView) -> Int {
      return 1
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return products.count
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      if let cell = tableView.cellForRow(at: indexPath) as? ProductCell {
         cell.setSelected(true, animated: true)
         if let product = cell.product {
            selectedProducts.append(product)
         }
      }
   }
   
   func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
      if let cell = tableView.cellForRow(at: indexPath) as? ProductCell {
         cell.setSelected(false, animated: true)
         guard let product = cell.product, let index = selectedProducts.index(where: { $0 === product }) else { return }
         selectedProducts.remove(at: index)
      }
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? ProductCell {
         cell.configureCell(with: products[indexPath.row])
         return cell
      }else {
         return UITableViewCell()
      }
   }
}
