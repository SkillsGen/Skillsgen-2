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
    
    let baseURL = URL(string: "http://0.0.0.0:5000/appinterface")!
    
    
    func fetchBookings(month: Int, year: Int, completion: @escaping ([Booking]?) -> Void)  {
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "query", value: "booking"),
            URLQueryItem(name: "mm", value: String(month)),
            URLQueryItem(name: "yyyy", value: String(year))
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
