//
//  BookingViewController.swift
//  Skillsgen
//
//  Created by Sebastian Reinolds on 20/12/2017.
//  Copyright © 2017 Sebastian Reinolds. All rights reserved.
//

import UIKit

class BookingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var booking: Booking?
    let dateFormatter = DateFormatter()
    
    @IBOutlet weak var bookingIdLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var publicPrivateLabel: UILabel!
    @IBOutlet weak var delCodeLabel: UILabel!
    @IBOutlet weak var bookCodeLabel: UILabel!
    @IBOutlet weak var trainerLabel: UILabel!
    @IBOutlet weak var trainerEmailSentLabel: UILabel!
    
    @IBOutlet weak var ordersTableView: UITableView!
    @IBOutlet weak var delegateTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int?
        
        if tableView == self.ordersTableView {
            if let orders: [Order] = booking!.orders {
                count = orders.count
            } else {
                count = 0
            }
        }
        
        if tableView == self.delegateTableView {
            if let delegates: [Delegate] = booking!.delegates {
                count = delegates.count
            } else {
                count = 0
            }
        }
        return count!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        
        if tableView == self.ordersTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath)
            if let order = booking?.orders![indexPath.row] {
                cell!.textLabel?.text = order.customer
                cell!.detailTextLabel?.text = "£" + String(order.totalWithVat)
            }
        }
        
        if tableView == self.delegateTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "DelegateCell", for: indexPath)
            if let delegate = booking?.delegates![indexPath.row] {
                cell!.textLabel?.text = delegate.name
            }
            
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String?
        
        if tableView == self.ordersTableView {
            title = "Orders:"
        }
        if tableView == self.delegateTableView {
            title = "Delegates:"
        }
        return title!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        bookingIdLabel.text = "ID: " + String(booking!.id)
        dateLabel.text = dateFormatter.string(from: booking!.date)
        startTimeLabel.text = booking!.start
        locationLabel.text = "Location: " + booking!.location
        courseLabel.text = booking!.course
        delCodeLabel.text = "Delegate: " + booking!.delcode
        bookCodeLabel.text = "Booker: " + booking!.bookcode
        trainerLabel.text = booking!.trainer
        
        if booking!.private {
            publicPrivateLabel.text = booking?.customer!
        } else {
            publicPrivateLabel.text = "Public"
        }
        
        if booking!.trainerEmailSent {
            trainerEmailSentLabel.text = "Trainer email sent ✔︎"
        } else {
            trainerEmailSentLabel.text = "Trainer email not sent yet"
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OrderSegue" {
            let destination = segue.destination as! OrderViewController
            let selectedIndexPath = ordersTableView.indexPathForSelectedRow!
            destination.order = booking!.orders![selectedIndexPath.row]
            destination.booking = booking!
        }
        else if segue.identifier == "MetricSegue" {
            let destination = segue.destination as! MetricsViewController
            if let booking = self.booking {
                destination.booking_id = booking.id
            }
        }
    }    
}
