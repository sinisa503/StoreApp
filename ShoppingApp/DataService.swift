//
//  DataService.swift
//  ShoppingApp
//
//  Created by Sinisa Vukovic on 10/08/2017.
//  Copyright © 2017 Sinisa Vukovic. All rights reserved.
//

import Foundation

protocol DataServiceProtocol {
    func getCurrenciesRates(_success: @escaping([Currency])->Void, _failure: @escaping(NetworkError)->Void)  
}

class DataService:DataServiceProtocol {
   
   public static let shared = DataService()
   
   private let API_KEY = "367a37be78f28f9431a9429b8e251e0f"
   private let BASE_ENDPOINT = "http://apilayer.net/api/live"
   private let LATEST_UPDATES_ENDPOINT = "live"
   private let QUOTES_ENDPOINT = "quotes"
   
   private let url:URL
   private let networkService = NetworkService.shared
   
   private init() {
      var components = URLComponents(string: BASE_ENDPOINT)
      let queryItemAccessKey = URLQueryItem(name: "access_key", value: API_KEY)
      let queryItemFormat = URLQueryItem(name: "format", value: "1")
      components?.queryItems = [queryItemAccessKey, queryItemFormat]
      
      url = (components?.url)!
   }
   
   /** Get currency rates in relation to US Dollar **/
   func getCurrenciesRates(_success: @escaping([Currency])->Void, _failure: @escaping(NetworkError)->Void) {
      networkService.getApiResponse(with: url, success: { (data) in
         if let jsonResult = try? JSONSerialization.jsonObject(with: data,
         options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String, AnyObject>{
            if let quotes = jsonResult?["quotes"] as? [String:AnyObject] {
               var currenciesArray:[Currency] = []
               for quote in quotes {
                  let currencyMark = Utilities.removeUSDPrefix(currency: quote.key)
                  guard let excangeRate = quote.value as? Double else { continue }
                  let currency = Currency(name: currencyMark, exchangeRate: excangeRate)
                  currenciesArray.append(currency)
               }
               _success(currenciesArray)
            }
         }
      }) { (error) in
         _failure(error)
      }
   }
}
