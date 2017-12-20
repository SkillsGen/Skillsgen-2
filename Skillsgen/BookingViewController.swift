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
                cell!.textLabel?.text = order.contact
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        bookingIdLabel.text = "BookingID: " + String(booking!.id)
        dateLabel.text = dateFormatter.string(from: booking!.date)
        startTimeLabel.text = booking!.start
        locationLabel.text = "Location: " + booking!.location
        courseLabel.text = booking!.course
        delCodeLabel.text = "Delegate: " + booking!.delcode
        bookCodeLabel.text = "Booker: " + booking!.bookcode
        
        if booking!.private {
            publicPrivateLabel.text = booking?.customer!
        } else {
            publicPrivateLabel.text = "Public"
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
