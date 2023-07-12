//
//  MetricsViewController.swift
//  Skillsgen
//
//  Created by Sebastian Reinolds on 12/07/2023.
//  Copyright © 2023 Sebastian Reinolds. All rights reserved.
//

import UIKit

class MetricsViewController: UIViewController {
    var metrics: [Metric] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello world")
        
        BackendController.shared.fetchMetrics(bookingid: 98) { (metrics) in
            if let metrics = metrics {
                DispatchQueue.main.async {
                    self.metrics = metrics
                    print(self.metrics)
                }
                
            } else {
                DispatchQueue.main.async {
                   print("something went wrong fetching metrics")
                }
            }
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
