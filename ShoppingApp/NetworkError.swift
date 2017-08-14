//
//  NetworkError.swift
//  ShoppingApp
//
//  Created by Sinisa Vukovic on 10/08/2017.
//  Copyright © 2017 Sinisa Vukovic. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
   
   case invalidAccessKey
   case noResults
   case exedeedSubscription
   case notFound
   
   case networkProblem(Error)
   case unknown(HTTPURLResponse?)
   case userCancelled
   
   
//MARK: Initialization
   public init(error: Error) {
      self = .networkProblem(error)
   }

   public init(response: URLResponse?) {
      guard let response = response as? HTTPURLResponse else {
         self = .unknown(nil)
         return
      }
      switch response.statusCode {
      case NetworkError.invalidAccessKey.statusCode: self = .invalidAccessKey
      case NetworkError.notFound.statusCode: self = .notFound
      default: self = .unknown(response)
      }
   }
   
   public var isAuthError: Bool {
      switch self {
      case .invalidAccessKey: return true
      default: return false
      }
   }
   
   public var statusCode: Int {
      switch self {
      case .invalidAccessKey: return 101
      case .noResults :return 106
      case .notFound: return 404
      case .exedeedSubscription: return 104
         
      case .networkProblem(_): return 10001
      case .unknown(_):        return 10002
      case .userCancelled(_):  return 99999
      }
   }
}

// MARK: - Equatable
extension NetworkError: Equatable {
   public static func ==(lhs: NetworkError, rhs: NetworkError) -> Bool {
      return lhs.statusCode == rhs.statusCode
   }
}
