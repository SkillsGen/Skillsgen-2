//
//  Order.swift
//  Skillsgen
//
//  Created by Sebastian Reinolds on 19/12/2017.
//  Copyright © 2017 Sebastian Reinolds. All rights reserved.
//

import Foundation

struct Order: Codable {
    var id: Int
    var bookingid: Int
    var contact: String
    var customer: String
    var address: String
    var notes: String?
    var sent: Bool
    var confirmed: Bool
    var invoiced: Bool
    var cancelled: Bool
    var total: Double
    var totalWithVat: Double
    
    var lineItems: [LineItem]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case bookingid
        case contact
        case customer
        case address
        case notes
        case sent
        case confirmed
        case invoiced
        case cancelled
        case lineItems = "lineitems"
        case total
        case totalWithVat
    }
    
    //
    // Fixing the types in the json (too late to fix the backend)
    //
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try valueContainer.decode(Int.self, forKey: CodingKeys.id)
        self.bookingid = try valueContainer.decode(Int.self, forKey: CodingKeys.bookingid)
        self.contact = try valueContainer.decode(String.self, forKey: CodingKeys.contact)
        self.customer = try valueContainer.decode(String.self, forKey: CodingKeys.customer)
        self.address = try valueContainer.decode(String.self, forKey: CodingKeys.address)
        self.notes = try? valueContainer.decode(String.self, forKey: CodingKeys.notes)
        
        if let lineItems = try? valueContainer.decode([LineItem].self, forKey: CodingKeys.lineItems) {
            self.lineItems = lineItems
            self.total = 0
            for i in lineItems {
                self.total += i.net
            }
            self.totalWithVat = self.total * 1.2
        } else {
            self.total = 0
            self.totalWithVat = 0
        }
        
        
        let sentInt = try valueContainer.decode(Int.self, forKey: CodingKeys.sent)
        self.sent = intToBool(sentInt)
        
        let confirmedString = try valueContainer.decode(String.self, forKey: CodingKeys.confirmed)
        self.confirmed = intToBool(Int(confirmedString)!)
        
        let invoicedInt = try valueContainer.decode(Int.self, forKey: CodingKeys.invoiced)
        self.invoiced = intToBool(invoicedInt)
        
        let cancelledInt = try valueContainer.decode(Int.self, forKey: CodingKeys.cancelled)
        self.cancelled = intToBool(cancelledInt)
    }
}
