//
//  Metrics.swift
//  Skillsgen
//
//  Created by Sebastian Reinolds on 12/07/2023.
//  Copyright © 2023 Sebastian Reinolds. All rights reserved.
//

import Foundation

struct Metric: Decodable {
    var id: Int
    
    var questionArray: [Int]

    
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
        
        self.questionArray = [Int](repeating: 0, count: 11)
        self.questionArray[0]  = try valueContainer.decode(Int.self, forKey: CodingKeys.q1)
        self.questionArray[1]  = try valueContainer.decode(Int.self, forKey: CodingKeys.q2)
        self.questionArray[2]  = try valueContainer.decode(Int.self, forKey: CodingKeys.q3)
        self.questionArray[3]  = try valueContainer.decode(Int.self, forKey: CodingKeys.q4)
        self.questionArray[4]  = try valueContainer.decode(Int.self, forKey: CodingKeys.q5)
        self.questionArray[5]  = try valueContainer.decode(Int.self, forKey: CodingKeys.q6)
        self.questionArray[6]  = try valueContainer.decode(Int.self, forKey: CodingKeys.q7)
        self.questionArray[7]  = try valueContainer.decode(Int.self, forKey: CodingKeys.q8)
        self.questionArray[8]  = try valueContainer.decode(Int.self, forKey: CodingKeys.q9)
        self.questionArray[9]  = try valueContainer.decode(Int.self, forKey: CodingKeys.q10)
        self.questionArray[10] = try valueContainer.decode(Int.self, forKey: CodingKeys.q11)

        self.comment = try valueContainer.decode(String.self, forKey: CodingKeys.comment)
        self.uplift  = try valueContainer.decode(String.self, forKey: CodingKeys.uplift)
    }
}
