//
//  EnquiriesViewController.swift
//  Skillsgen
//
//  Created by Sebastian Reinolds on 26/02/2018.
//  Copyright © 2018 Sebastian Reinolds. All rights reserved.
//

import UIKit

class EnquiriesViewController: UITableViewController {
    var enquiries: [Enquiry] = []
    let backendController = BackendController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        backendController.fetchEnquiries() { (enquiries) in
            if let enquiries = enquiries {
                DispatchQueue.main.async {
                    self.enquiries = enquiries
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return enquiries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EnquiryCell", for: indexPath)
        let enquiry = enquiries[indexPath.row]
        cell.textLabel?.text = enquiry.name
        cell.detailTextLabel?.text = enquiry.timestamp
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EnquirySegue" {
            let enquiryViewController = segue.destination as! EnquiryViewController
            let index = tableView.indexPathForSelectedRow!.row
            enquiryViewController.enquiry = enquiries[index]
        }
    }
}

