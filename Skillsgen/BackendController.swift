//
//  BackendController.swift
//  Skillsgen
//
//  Created by Sebastian Reinolds on 19/12/2017.
//  Copyright © 2017 Sebastian Reinolds. All rights reserved.
//

import Foundation

class BackendController {
    static let shared = BackendController()
    
    func fetchBookings(month: Int, year: Int, completion: @escaping ([Booking]?) -> Void)  {
        
        let yearString = String(year)
        var monthString = ""
        if month < 10 {
            monthString = "0" + String(month)
        } else {
            monthString = String(month)
        }
        
        var components = URLComponents(url: Config.baseURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "query", value: "booking"),
            URLQueryItem(name: "mm", value: monthString),
            URLQueryItem(name: "yyyy", value: yearString),
            URLQueryItem(name: Config.authQuery, value: Config.authValue)
            
        ]
        let url = components.url!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let bookings = try? jsonDecoder.decode([Booking].self, from: data)
            {
                completion(bookings)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}
