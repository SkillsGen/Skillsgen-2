//
//  LineItem.swift
//  Skillsgen
//
//  Created by Sebastian Reinolds on 19/12/2017.
//  Copyright © 2017 Sebastian Reinolds. All rights reserved.
//

import Foundation

struct LineItem: Codable {
    var id: Int
    var orderid: Int
    var description: String
    var unitPrice: Double
    var quantity: Int
    var net: Double
    var vat: Bool
    var total: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case orderid
        case description
        case unitPrice = "unitprice"
        case quantity
        case net
        case vat
        case total
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try valueContainer.decode(Int.self, forKey: CodingKeys.id)
        self.orderid = try valueContainer.decode(Int.self, forKey: CodingKeys.orderid)
        self.description = try valueContainer.decode(String.self, forKey: CodingKeys.description)
        self.quantity = try valueContainer.decode(Int.self, forKey: CodingKeys.quantity)
        
        let unitPriceString = try valueContainer.decode(String.self, forKey: CodingKeys.unitPrice)
        self.unitPrice = Double(unitPriceString)!
        
        self.net = self.unitPrice * Double(self.quantity)
        
        let vatInt = try valueContainer.decode(Int.self, forKey: CodingKeys.vat)
        self.vat = intToBool(vatInt)
        
        if self.vat == true {
            self.total = self.net * 1.2
        } else {
            self.total = self.net
        }
        
    }
}
