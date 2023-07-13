//
//  Metrics.swift
//  Skillsgen
//
//  Created by Sebastian Reinolds on 12/07/2023.
//  Copyright © 2023 Sebastian Reinolds. All rights reserved.
//

import Foundation

struct Metric: Codable {
    var id: Int
    var q1: Int
    var q2: Int
    var q3: Int
    var q4: Int
    var q5: Int
    var q6: Int
    var q7: Int
    var q8: Int
    var q9: Int
    var q10: Int
    var q11: Int    
    var comment: String
    var uplift: String


    enum CodingKeys: String, CodingKey {
        case id
        case q1
        case q2
        case q3
        case q4
        case q5
        case q6
        case q7
        case q8
        case q9
        case q10
        case q11
        case comment = "q12"
        case uplift  = "q13"
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try valueContainer.decode(Int.self, forKey: CodingKeys.id)
        self.q1  = try valueContainer.decode(Int.self, forKey: CodingKeys.q1)
        self.q2  = try valueContainer.decode(Int.self, forKey: CodingKeys.q2)
        self.q3  = try valueContainer.decode(Int.self, forKey: CodingKeys.q2)
        self.q4  = try valueContainer.decode(Int.self, forKey: CodingKeys.q1)
        self.q5  = try valueContainer.decode(Int.self, forKey: CodingKeys.q2)
        self.q6  = try valueContainer.decode(Int.self, forKey: CodingKeys.q2)
        self.q7  = try valueContainer.decode(Int.self, forKey: CodingKeys.q1)
        self.q8  = try valueContainer.decode(Int.self, forKey: CodingKeys.q2)
        self.q9  = try valueContainer.decode(Int.self, forKey: CodingKeys.q2)
        self.q10 = try valueContainer.decode(Int.self, forKey: CodingKeys.q2)
        self.q11 = try valueContainer.decode(Int.self, forKey: CodingKeys.q2)
        self.comment = try valueContainer.decode(String.self, forKey: CodingKeys.comment)
        self.uplift  = try valueContainer.decode(String.self, forKey: CodingKeys.uplift)
    }
}
