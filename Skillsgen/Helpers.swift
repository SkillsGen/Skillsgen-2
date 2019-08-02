//
//  Helpers.swift
//  Skillsgen
//
//  Created by Sebastian Reinolds on 19/12/2017.
//  Copyright © 2017 Sebastian Reinolds. All rights reserved.
//

import Foundation
import UIKit
import CryptoSwift

func GeneratePass(KeyString: String) -> String {
    let dateFormatter = DateFormatter()
    let date = Date()
    
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    dateFormatter.dateFormat = "MMddHHmm"
    
    let DateString = dateFormatter.string(from: date)
    let TimeBytes = DateString.bytes.sha256()
    
    let KeyBytes = Array<UInt8>(hex: KeyString)
    
    var Output: Array<UInt8> = Array()
    for index in 0..<KeyBytes.count {
        Output.append(TimeBytes[index] ^ KeyBytes[index])
    }
    
    Output = Output.sha256()
    
    return Output.toHexString()
}


func intToBool(_ int:Int) -> Bool {
    if int == 1 {
        return true
    } else {
        return false
    }
}

func getCurrentMonthAndYear() -> (month: Int, year: Int) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMyyyy"
    let date = Date()
    let dateString = dateFormatter.string(from: date)
    let seperatorIndex = dateString.index(dateString.startIndex, offsetBy: 2)
    let month = dateString.prefix(upTo: seperatorIndex)
    let year = dateString.suffix(from: seperatorIndex)
    
    return (Int(month)!, Int(year)!)
}

func createDateLabelString(month: Int, year: Int) -> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM"
    let date = dateFormatter.date(from: String(month))!
    dateFormatter.dateFormat = "MMMM"
    let monthString = dateFormatter.string(from: date)
    
    return "< " + monthString + " - " + String(year) + " >"
}

extension UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        guard let window = UIApplication.shared.keyWindow else {
            return super.sizeThatFits(size)
        }
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = window.safeAreaInsets.bottom + 30
        return sizeThatFits
    }
}
