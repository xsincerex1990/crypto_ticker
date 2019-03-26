//
//  DataModel.swift
//  crypto_ticker
//
//  Created by Joel alexis on 3/24/19.
//  Copyright © 2019 Joel alexis. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit


class DataModel {
    
    var finalSymbol = ""
    var finalURL = ""
    var finalCryptoCurrency = ""
    var finalPrice = ""
    var finalConversion = ""
    var err: Error?
    
    let apiKey = "79399b89-e8bf-4529-a359-1c509b7bfee9"
    let currency = ["USD", "EUR", "CNY"]
    let currencySymbols = ["$","€", "¥"]
    let BaseURL = "https://pro-api.coinmarketcap.com"
    

    func getPrice(url: String) {
        let headers: HTTPHeaders = [
        "X-CMC_PRO_API_KEY": "79399b89-e8bf-4529-a359-1c509b7bfee9",
        "Accept": "application/json"
        ]

        Alamofire.request(finalURL, headers: headers).validate().responseJSON  {
        response in
        
            switch response.result {
            
            case .success(let value):
                
                let Json = JSON(value)
                let JsonPrice = Json["data"]["\(self.finalCryptoCurrency)"]["quote"]["\(self.finalConversion)"]["price"]
                
                if let set = JsonPrice.double {
                    if set < 1 {
                        self.finalPrice = String(format: "%.4f", set)
                    } else {
                        self.finalPrice = String(Int(set))
                    }
                }
                
            case .failure(let error):
                self.err = error
                print(error)
            }
        }
    }
}
