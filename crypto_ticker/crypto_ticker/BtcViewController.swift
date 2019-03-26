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

class BtcViewController:  UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var btcPriceLabel: UILabel!
    @IBOutlet weak var btcPickerView: UIPickerView!

    @IBOutlet weak var pageSwipe: UIPageControl!
    
    // not sure if data model is the right name for that class
    let dataModel = DataModel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //set self as delegate
        btcPickerView.delegate = self
        btcPickerView.dataSource = self
        
        //set the look of page indicators
        pageSwipe.numberOfPages = 2
        pageSwipe.currentPage = 0
        

    }

    @IBAction func PageSwipeAction(_ sender: Any) {
        performSegue(withIdentifier: "btcToCardano", sender: self)
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
        dataModel.finalSymbol = dataModel.currencySymbols[row]
        dataModel.finalCryptoCurrency = "BTC"
        dataModel.finalURL = dataModel.BaseURL + "/v1/cryptocurrency/quotes/latest?symbol=BTC&convert=" + dataModel.currency[row]
        dataModel.getPrice(url: dataModel.finalURL)
    
        if dataModel.finalPrice != "" {
            setPriceLabel(finalPrice: dataModel.finalPrice)
        } else {
             if dataModel.err != nil {
             print(dataModel.err!)
            }
        }
    }
    
    func setPriceLabel(finalPrice: String) {
        btcPriceLabel.text = "\(dataModel.finalSymbol) " + finalPrice
    }
    
    func errorHandler(err: Error) {
        print(err)
        btcPriceLabel.text = "Connection Error"
    }
}

