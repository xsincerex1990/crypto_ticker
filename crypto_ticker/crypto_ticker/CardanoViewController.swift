//
//  ViewController.swift
//  crypto_ticker
//
//  Created by Joel alexis on 3/23/19.
//  Copyright © 2019 Joel alexis. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CardanoViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var CardanoPriceField: UILabel!
    @IBOutlet weak var CardanoPickerView: UIPickerView!
    @IBOutlet weak var pageSwipe: UIPageControl!
    
    let dataModel = DataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CardanoPickerView.delegate = self
        CardanoPickerView.dataSource = self
        pageSwipe.currentPage = 1
        pageSwipe.numberOfPages = 2
    }
    
    @IBAction func swipeButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "AdaToBtc", sender: self)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataModel.currency.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        dataModel.finalConversion = dataModel.currency[row]
        return dataModel.currency[row]
    }

    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        dataModel.finalURL = dataModel.BaseURL + "/v1/cryptocurrency/quotes/latest?symbol=ADA&convert="
        dataModel.finalSymbol = dataModel.currencySymbols[row]
        dataModel.finalCryptoCurrency = "ADA"
        dataModel.finalURL = dataModel.BaseURL + "/v1/cryptocurrency/quotes/latest?symbol=ADA&convert=" + dataModel.currency[row]
        dataModel.getPrice(url: dataModel.finalURL)
        
        if dataModel.finalPrice != "" {
            setPriceLabel(finalPrice: dataModel.finalPrice)
        } else {
            if dataModel.err != nil {
                print(dataModel.err!)
                CardanoPriceField.text = "Connection Error"
            }
        }
        
    }
    
    func setPriceLabel(finalPrice: String){
        CardanoPriceField.text = "\(dataModel.finalSymbol) " + finalPrice
    }

}
