//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by Angela Yu on 23/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    let pickerDataModel: PickerDataModel = PickerDataModel()
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    var finalURL = ""

    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var weekPriceLebel: UILabel!
    @IBOutlet weak var monthPriceLebel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
    }

    
    //TODO: Place your 3 UIPickerView delegate methods here
    //@numberOfComponents -> set the number of coloums in picker View
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //@pickerView with return type int and params numberOfRowsInComponent and pickerView -> set the number of rows in picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataModel.dataSize()
    }
    //@pickerView with params titleForRow and pickerView -> loading the arrays of items in the picker view
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataModel.getCurrency(index: row)
    }
    //@pickerView with params didSelectRow -> set up the delegate 'this method is called everytime the user choose an item
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(pickerDataModel.getCurrency(index: row))
        finalURL = baseURL + pickerDataModel.getCurrency(index: row)
        print("URL: \(finalURL)")
        pickerDataModel.releaseData()
        pickerDataModel.setCurrenySymbol(index: row)
        getBitcoinData(url: finalURL)
    }
    

    
    
    
//    
//    //MARK: - Networking
// /***************************************************************/
//
    func getBitcoinData(url: String){
        Alamofire.request(finalURL, method: .get).responseJSON { response in
            if response.result.isSuccess{
                print("connection succeed")
                let jsonResponse: JSON = JSON(response.result.value!)
                print(jsonResponse)
                self.parseJSONfile(file: jsonResponse)
            }
            else {
                print("connection failed")
            }
        }
    }

//    //MARK: - JSON Parsing
//    /***************************************************************/
//
    func parseJSONfile(file: JSON){
        if let dayResult = file["averages"]["day"].int {
            pickerDataModel.setBitcoinDayMean(value: file["averages"]["day"].stringValue)
            pickerDataModel.setBitcoinWeekMean(value: file["averages"]["week"].stringValue)
            pickerDataModel.setBitcoinMonthMean(value: file["averages"]["month"].stringValue)
            print("JSON file parsing Succeed")
            self.updateUIView()
        }
        else {
            print("JSON flie error!")
        }
    }
    
    func updateUIView(){
        bitcoinPriceLabel.text = "Daily Mean: \(pickerDataModel.getBitcoinDayMean())"
        print(pickerDataModel.getBitcoinDayMean())
        weekPriceLebel.text = "Weekly Mean: \(pickerDataModel.getBitcoinWeekMean())"
        print(pickerDataModel.getBitcoinWeekMean())
        monthPriceLebel.text = "Monthly Mean: \(pickerDataModel.getBitcoinMonthMean())"
        print(pickerDataModel.getBitcoinMonthMean())
    }


}

