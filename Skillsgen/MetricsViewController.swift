//
//  MetricsViewController.swift
//  Skillsgen
//
//  Created by Sebastian Reinolds on 12/07/2023.
//  Copyright © 2023 Sebastian Reinolds. All rights reserved.
//

import UIKit

class MetricsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var metrics: [Metric] = []
    var booking_id: Int?
    
    var comments: [String] = []
    
    @IBOutlet weak var commentsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello world")
        self.commentsTable.estimatedRowHeight = 44.0
        self.commentsTable.rowHeight = UITableView.automaticDimension
        self.commentsTable.separatorStyle = .singleLine
        


        BackendController.shared.fetchMetrics(bookingid: booking_id!) { (metrics) in
            if let metrics = metrics {
                DispatchQueue.main.async {
                    self.metrics = metrics
                    for metric in metrics {
                        var validComment = false
                        if metric.comment.count > 0 {
                            for char in metric.comment {
                                if char != " " {
                                    validComment = true
                                    break
                                }
                            }
                        }

                        if validComment {
                            self.comments.append(metric.comment)
                        }
                    }
                    self.commentsTable.reloadData()
                }
            } else {
                DispatchQueue.main.async {
                   print("something went wrong fetching metrics")
                }
            }
        }

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentTableViewCell
      
        cell.comment?.text = self.comments[indexPath.row]        
        return cell
    }
        
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Comments"
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
