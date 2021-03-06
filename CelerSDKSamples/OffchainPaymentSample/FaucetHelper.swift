//
//  FaucetHelper.swift
//  CelerSDKSamples
//
//  Created by Jinyao Li on 10/23/18.
//

import Foundation

enum FaucetResult {
  case success(message: String)
  case failure(message: String)
}

final class FaucetHelper {
  
  static let shared = FaucetHelper()
  private init() {}

  func sendToken(to accountAddress: String, from faucetAddress: String, resultHandler: @escaping ((FaucetResult) -> Void) ) {
    URLSession.shared.dataTask(with: URL(string: "\(faucetAddress)\(accountAddress)")!) { data, response, error in
      if let error = error {
        resultHandler(.failure(message: error.localizedDescription))
        return
      }
      
      guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
        resultHandler(.failure(message: String(describing: response)))
        return
      }
      resultHandler(.success(message: "Fuel account: \(accountAddress) successfully."))
    }.resume()
  }
}
