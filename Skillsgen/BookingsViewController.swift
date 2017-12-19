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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateLabel.text = createDateLabelString(month: month, year: year)
        updateUI()
    }

    func updateUI() {
        
        backendController.fetchBookings(month: month, year: year) { (bookings) in
            if let bookings = bookings {
                DispatchQueue.main.async {
                    self.bookings = bookings
                    self.tableView.reloadData()
                    self.dateLabel.text = createDateLabelString(month: self.month, year: self.year)
                }
                
            }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingCellIdentifier", for: indexPath)
        
        cell.textLabel?.text = String(bookings[indexPath.row].id)
        cell.detailTextLabel?.text = bookings[indexPath.row].course
        return cell
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
