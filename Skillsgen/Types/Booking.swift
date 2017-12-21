//
//  Booking.swift
//  Skillsgen
//
//  Created by Sebastian Reinolds on 19/12/2017.
//  Copyright © 2017 Sebastian Reinolds. All rights reserved.
//

import Foundation

struct Booking: Codable {
    var id: Int
    var date: Date
    var start: String
    var course: String
    var duration: Int
    var trainer: String
    var `private`: Bool
    var cancelled: Bool
    var location: String
    var bookcode: String
    var delcode: String
    var trainerEmailSent: Bool
    var notes: String?
    var customer: String?
    var delegates: [Delegate]?
    var orders: [Order]?
    
    var delCount: Int {
        var count: Int?
        if let delegates = self.delegates {
            count = delegates.count
        } else {
            count = 0
        }
        return count!
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case date
        case start
        case course
        case trainer
        case `private`
        case cancelled
        case duration
        case location
        case bookcode
        case delcode
        case trainerEmailSent = "traineremail"
        case notes
        case customer
        case delegates
        case orders
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try valueContainer.decode(Int.self, forKey: CodingKeys.id)
        self.start = try valueContainer.decode(String.self, forKey: CodingKeys.start)
        self.course = try valueContainer.decode(String.self, forKey: CodingKeys.course)
        self.trainer = try valueContainer.decode(String.self, forKey: CodingKeys.trainer)
        self.location = try valueContainer.decode(String.self, forKey: CodingKeys.location)
        self.bookcode = try valueContainer.decode(String.self, forKey: CodingKeys.bookcode)
        self.delcode = try valueContainer.decode(String.self, forKey: CodingKeys.delcode)
        self.notes = try? valueContainer.decode(String.self, forKey: CodingKeys.notes)
        self.customer = try? valueContainer.decode(String.self, forKey: CodingKeys.customer)
        self.delegates = try? valueContainer.decode([Delegate].self, forKey: CodingKeys.delegates)
        self.orders = try? valueContainer.decode([Order].self, forKey: CodingKeys.orders)
        
        //
        // Fixing the types in the json (too late to fix the backend)
        //
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = try valueContainer.decode(String.self, forKey: CodingKeys.date)
        self.date = dateFormatter.date(from: dateString)!
        
        let traineremailInt = try valueContainer.decode(Int.self, forKey: CodingKeys.trainerEmailSent)
        self.trainerEmailSent = intToBool(traineremailInt)
        
        let privateInt = try valueContainer.decode(Int.self, forKey: CodingKeys.`private`)
        self.private = intToBool(privateInt)
        
        let cancelledInt = try valueContainer.decode(Int.self, forKey: CodingKeys.cancelled)
        self.cancelled = intToBool(cancelledInt)
        
        let durationString: String = try! valueContainer.decode(String.self, forKey: CodingKeys.duration)
        self.duration = Int(durationString)!
    }
}
