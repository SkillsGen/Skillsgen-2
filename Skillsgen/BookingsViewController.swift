//
//  BookingsViewController.swift
//  Skillsgen
//
//  Created by Sebastian Reinolds on 19/12/2017.
//  Copyright © 2017 Sebastian Reinolds. All rights reserved.
//

import UIKit

class BookingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loadingDescription: UILabel!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var retryButton: UIButton!
    
    
    let backendController = BackendController()
    var bookings: [Booking] = []
    var month = getCurrentMonthAndYear().month
    var year = getCurrentMonthAndYear().year
    
    
    @IBAction func prevButtonTapped(_ sender: Any) {
        if self.month > 1 {
            self.month -= 1
        } else {
            self.month = 12
            self.year -= 1
        }
        self.updateUI()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        if month < 12 {
            month += 1
        } else {
            month = 1
            year += 1
        }
        updateUI()
    }
    
    
    @IBAction func retryButtonTapped(_ sender: Any) {
        retryButton.isHidden = true
        loadingActivityIndicator.isHidden = false
        updateUI("Retrying...")
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        retryButton.isHidden = true
        loadingView.backgroundColor = UIColor(displayP3Red: 0.27, green: 0.27, blue: 0.27, alpha: 0.7)
        loadingView.layer.cornerRadius = 10
        
        dateLabel.text = createDateLabelString(month: month, year: year)
        
        BackendController.shared.fetchEnquiries { (bool) in
            if bool == true {
                self.updateBadgeNumber(BackendController.shared.enquiries)
            }
        }
        updateBadgeNumber(BackendController.shared.enquiries)
        updateUI()
    }

    @objc func swipe(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if swipeGesture.direction == UISwipeGestureRecognizerDirection.left {
                if month < 12 {
                    month += 1
                } else {
                    month = 1
                    year += 1
                }
                updateUI()
            } else if swipeGesture.direction == UISwipeGestureRecognizerDirection.right {
                if self.month > 1 {
                    self.month -= 1
                } else {
                    self.month = 12
                    self.year -= 1
                }
                self.updateUI()
            }
        }
    }
    
    
    func updateUI(_ loadingMessage: String? = nil) {
        if let loadingMessage = loadingMessage {
            self.loadingDescription.text = loadingMessage
        } else {
            self.loadingDescription.text = "Loading Bookings"
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        tableView.isHidden = true
        loadingView.isHidden = false
        
        loadingActivityIndicator.isHidden = false
        backendController.fetchBookings(month: month, year: year) { (bookings) in
            if let bookings = bookings {
                DispatchQueue.main.async {
                    self.bookings = bookings
                    self.tableView.reloadData()
                    self.dateLabel.text = createDateLabelString(month: self.month, year: self.year)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self.tableView.isHidden = false
                    self.loadingView.isHidden = true
                }
                
            } else {
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self.loadingDescription.text = "Something went wrong"
                    self.loadingActivityIndicator.isHidden = true
                    self.retryButton.layer.cornerRadius = 4
                    self.retryButton.isHidden = false
                }
            }
        }
    }

    
    func updateBadgeNumber(_ enquiries: [Enquiry]) {
        var newCount: Int = 0
        for enquiry in enquiries {
            if enquiry.viewed == false {
                newCount += 1
            }
        }
        if newCount == 0 {
            tabBarController?.tabBar.items?[1].badgeValue = nil
        } else {
            tabBarController?.tabBar.items?[1].badgeValue = String(newCount)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingCellIdentifier", for: indexPath) as! BookingTableViewCell
        
        cell.cellDateFormatter.dateFormat = "d"
        let booking = bookings[indexPath.row]
        
        cell.dayOfMonthLabel?.text = cell.cellDateFormatter.string(from: booking.date)
        cell.courseLabel?.text = booking.course
        cell.trainerLabel?.text = booking.trainer
        cell.noOfDelegatesLabel?.text = String(booking.delCount)
        
        if let customer = booking.customer {
            cell.customerLabel?.text = customer
            cell.customerLabel.textColor = .green
        } else {
            cell.customerLabel?.text = "Public"
            cell.customerLabel.textColor = .blue
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BookingSegue" {
            let destination = segue.destination as! BookingViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow
            destination.booking = bookings[selectedIndexPath!.row]
        }
        
    }
    

}
