//
//  NetworkService.swift
//  ShoppingApp
//
//  Created by Sinisa Vukovic on 09/08/2017.
//  Copyright © 2017 Sinisa Vukovic. All rights reserved.
//

import Foundation

class NetworkService {
   
   private let session = URLSession.shared
   public static let shared: NetworkService = NetworkService()
   
   func getApiResponse(with url:URL, success _success: @escaping (Data) -> Void,
                      failure _failure: @escaping (NetworkError) -> Void) {
   
      let task = session.dataTask(with: url) { (data, response, error) in
         if let error = error {
            _failure(NetworkError(error: error))
         }else {
            if let data = data {
            _success(data)
            }
         }
      }
      task.resume()
   }
}
