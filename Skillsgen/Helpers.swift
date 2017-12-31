//
//  Helpers.swift
//  Skillsgen
//
//  Created by Sebastian Reinolds on 19/12/2017.
//  Copyright © 2017 Sebastian Reinolds. All rights reserved.
//

import Foundation

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
