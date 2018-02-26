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
}
