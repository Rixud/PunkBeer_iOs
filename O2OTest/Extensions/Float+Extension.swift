//
//  Float+Extension.swift
//  O2OTest
//
//  Created by Luis Guerra on 10/6/21.
//

import Foundation


extension Double{

    func formatterAmount() -> String{
        let doubleAsStrings = String(format: "%.2f", self)
            .components(separatedBy: ".")
        if var integerPart = doubleAsStrings.first,
            integerPart.count == 4 {//Si la parte entera tiene 4 dígitos se coloca el punto "."
            integerPart.insert(".", at: integerPart.index(integerPart.startIndex, offsetBy: 1))
                return integerPart + "," + doubleAsStrings[1]
        }else{
            let currencyFormatter = NumberFormatter()
            currencyFormatter.numberStyle = .currency
            currencyFormatter.usesGroupingSeparator = true
            currencyFormatter.locale = Locale(identifier: "es_ES")
            if let priceString = currencyFormatter.string(from: self as NSNumber){
                return String(priceString.prefix(priceString.count - 2))
            }
        }
        return ""
    }
}
