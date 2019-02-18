//
//  PickerDataModel.swift
//  BitcoinTicker
//
//  Created by Ahmed Ahmed on 11/27/18.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import Foundation

class PickerDataModel{
    
    private let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    private let currencySymbol = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    private var bitcoinDayMean: String = ""
    private var bitcoinWeekMean: String = ""
    private var bitcoinMonthMean: String = ""
    
    func getCurrency(index: Int) -> String{
        return currencyArray[index]
    }
    
    func setCurrenySymbol(index: Int){
        bitcoinDayMean += currencySymbol[index]
        bitcoinWeekMean += currencySymbol[index]
        bitcoinMonthMean += currencySymbol[index]
    }
    
    func dataSize() -> Int {
        return currencyArray.count
    }
    func releaseData(){
        bitcoinDayMean = ""
        bitcoinWeekMean = ""
        bitcoinMonthMean = ""
    }
    
    // fay setter and getter
    func setBitcoinDayMean(value: String){
        bitcoinDayMean += value
    }
    func getBitcoinDayMean() -> String {
        return bitcoinDayMean
    }
    
    // week setter and getter
    func setBitcoinWeekMean(value: String){
        bitcoinWeekMean += value
    }
    func getBitcoinWeekMean() -> String {
        return bitcoinWeekMean
    }
    
    // year setter and getter
    func setBitcoinMonthMean(value: String){
        bitcoinMonthMean += value
    }
    func getBitcoinMonthMean() -> String {
        return bitcoinMonthMean
    }
    
}
