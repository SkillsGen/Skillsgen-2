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
    let errorLoadingView = UIView()
    let errorLoadingMessage = UILabel()
    let errorRetryButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpErrorView()
        
        updateUI()
    }
    
    @objc func retryButtonTapped(_ sender: UIButton) {
        updateUI()
    }
    
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        updateUI()
    }
    
    
    func updateUI() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        BackendController.shared.fetchEnquiries() { (enquiries) in
            if let enquiries = enquiries {
                DispatchQueue.main.async {
                    self.enquiries = enquiries
                    self.tableView.reloadData()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self.errorLoadingView.isHidden = true
                    self.updateBadgeNumber()
                }
            } else {
                DispatchQueue.main.async {
                    self.enquiries = []
                    self.tableView.reloadData()
                    self.errorLoadingView.isHidden = false
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
        }
    }
    
    
    func updateBadgeNumber() {
        var newCount: Int = 0
        for enquiry in self.enquiries {
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
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return enquiries.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EnquiryCell", for: indexPath)
        let enquiry = enquiries[indexPath.row]
        cell.textLabel?.text = enquiry.name
        cell.detailTextLabel?.text = enquiry.timestamp
        if enquiry.viewed == false {
            cell.backgroundColor = .red
        } else {
            cell.backgroundColor = .white
        }
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EnquirySegue" {
            let enquiryViewController = segue.destination as! EnquiryViewController
            let index = tableView.indexPathForSelectedRow!.row
            self.enquiries[index].viewed = true
            enquiryViewController.enquiry = enquiries[index]
        }
        self.updateBadgeNumber()
        self.tableView.reloadData()
    }
    
    func setUpErrorView() {
        errorLoadingView.isHidden = true
        errorLoadingView.frame = CGRect(x: super.view.frame.width / 2 - 135, y: super.view.frame.width / 2, width: 270, height: 140)
        errorLoadingView.backgroundColor = UIColor(displayP3Red: 0.27, green: 0.27, blue: 0.27, alpha: 0.7)
        errorLoadingView.layer.cornerRadius = 10
        
        errorLoadingMessage.text = "Couldn't Load Enquiries"
        errorLoadingMessage.font = UIFont.systemFont(ofSize: 23.0)
        errorLoadingMessage.textColor = .white
        errorLoadingMessage.textAlignment = .center
        errorLoadingMessage.frame = CGRect(x: 10, y: 30, width: 250, height: 30)
        errorLoadingView.addSubview(errorLoadingMessage)
        
        errorRetryButton.setTitle("Retry", for: .normal)
        errorRetryButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        errorRetryButton.layer.cornerRadius = 4
        errorRetryButton.backgroundColor = .blue
        errorRetryButton.titleLabel!.textColor = .white
        errorRetryButton.frame = CGRect(x: 95, y: 80, width: 80, height: 35)
        errorRetryButton.layer.opacity = 0.8
        errorRetryButton.addTarget(self, action: #selector(self.retryButtonTapped(_:)), for: .touchUpInside)
        errorLoadingView.addSubview(errorRetryButton)
        
        super.view.addSubview(errorLoadingView)
    }
}

