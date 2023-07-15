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
    
    @IBOutlet weak var NoOfResponses: UILabel!
    @IBOutlet weak var Excellent: UILabel!
    @IBOutlet weak var Good: UILabel!
    @IBOutlet weak var Satisfactory: UILabel!
    @IBOutlet weak var BelowAverage: UILabel!
    @IBOutlet weak var Poor: UILabel!
    @IBOutlet weak var commentsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        self.commentsTable.estimatedRowHeight = 44.0
        self.commentsTable.rowHeight = UITableView.automaticDimension
        self.commentsTable.separatorStyle = .singleLine
        
        
        BackendController.shared.fetchMetrics(bookingid: booking_id!) { (metrics) in
            if let metrics = metrics {
                DispatchQueue.main.async {
                    var ExcellentCount = 0
                    var GoodCount = 0
                    var SatisfactoryCount = 0
                    var BelowAverageCount = 0
                    var PoorCount = 0
                    
                    var questionCount = 0
                    if metrics.count > 0
                    {
                        self.metrics = metrics
                        for metric in metrics {
                            questionCount = metric.questionArray.count
                            for question in metric.questionArray {
                                switch question {
                                case 1: PoorCount += 1
                                case 2: BelowAverageCount += 1
                                case 3: SatisfactoryCount += 1
                                case 4: GoodCount += 1
                                case 5: ExcellentCount += 1
                                default:
                                    print("i don't want to do anything in this case but i have to so i printed this string thanks swift")
                                }
                            }
                            
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
                        
                        self.NoOfResponses.text = "Responses: \(metrics.count)"
                        let excellentPercent = Float(ExcellentCount)/(Float(metrics.count)*Float(questionCount)) * 100
                        self.Excellent.text = "Excellent: \(excellentPercent.rounded())%"
                        let goodPercent = Float(GoodCount)/(Float(metrics.count)*Float(questionCount)) * 100
                        self.Good.text = "Good: \(goodPercent.rounded())%"
                        let satisfactoryPercent = Float(SatisfactoryCount)/(Float(metrics.count)*Float(questionCount)) * 100
                        self.Satisfactory.text = "Satisfactory: \(satisfactoryPercent.rounded())%"
                        let belowAveragePercent = Float(BelowAverageCount)/(Float(metrics.count)*Float(questionCount)) * 100
                        self.BelowAverage.text = "BelowAverage: \(belowAveragePercent.rounded())%"
                        let poorPercent = Float(PoorCount)/(Float(metrics.count)*Float(questionCount)) * 100
                        self.Poor.text = "Poor: \(poorPercent.rounded())%"
                    }
                    else
                    {
                        self.NoOfResponses.text = "No metrics submitted yet"                        
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.NoOfResponses.text = "Couldn't fetch metrics"
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
