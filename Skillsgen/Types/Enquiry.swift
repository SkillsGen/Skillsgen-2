//
//  Enquiry.swift
//  Skillsgen
//
//  Created by Sebastian Reinolds on 26/02/2018.
//  Copyright © 2018 Sebastian Reinolds. All rights reserved.
//

import Foundation

struct Enquiry: Codable {
    let id: Int
    let name: String
    let email: String
    let phone: String?
    let enquiry: String
    let timestamp: String
    var viewed: Bool
    var date: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case phone
        case enquiry
        case timestamp
        case viewed
        case date
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try valueContainer.decode(Int.self, forKey: CodingKeys.id)
        self.name = try valueContainer.decode(String.self, forKey: CodingKeys.name)
        self.email = try valueContainer.decode(String.self, forKey: CodingKeys.email)
        self.phone = try? valueContainer.decode(String.self, forKey: CodingKeys.phone)
        self.enquiry = try valueContainer.decode(String.self, forKey: CodingKeys.enquiry)
        self.timestamp = try valueContainer.decode(String.self, forKey: CodingKeys.timestamp)
        
        if let viewed = try? valueContainer.decode(Bool.self, forKey: CodingKeys.viewed) {
            self.viewed = viewed
        } else {
            self.viewed = false
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY - HH:mm"
        self.date = dateFormatter.date(from: self.timestamp)!
    }
}

struct DynamicEnquiry: Codable {
    let id: Int
    let name: String
    let email: String
    let phone: String?
    let enquiry: String
    let timestamp: String
    var viewed: Bool
    var date: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case phone
        case enquiry
        case timestamp
        case viewed
        case date
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try valueContainer.decode(Int.self, forKey: CodingKeys.id)
        self.name = try valueContainer.decode(String.self, forKey: CodingKeys.name)
        self.email = try valueContainer.decode(String.self, forKey: CodingKeys.email)
        self.phone = try? valueContainer.decode(String.self, forKey: CodingKeys.phone)
        self.enquiry = try valueContainer.decode(String.self, forKey: CodingKeys.enquiry)
        self.timestamp = try valueContainer.decode(String.self, forKey: CodingKeys.timestamp)
        
        self.viewed = false
        if let viewedJSON = try? valueContainer.decode(Int.self, forKey: CodingKeys.viewed) {
            if(viewedJSON) == 1 {
                self.viewed = true
            }
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY - HH:mm"
        self.date = dateFormatter.date(from: self.timestamp)!
    }
}

struct EnquiriesJSON: Codable {
    let totalCount: Int
    var webEnquiries: [DynamicEnquiry]
}
