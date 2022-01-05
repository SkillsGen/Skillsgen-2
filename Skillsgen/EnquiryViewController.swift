//
//  EnquiryViewController.swift
//  Skillsgen
//
//  Created by Sebastian Reinolds on 26/02/2018.
//  Copyright © 2018 Sebastian Reinolds. All rights reserved.
//

import UIKit

class EnquiryViewController: UIViewController {

    var dynamicEnquiry: DynamicEnquiry!
    var enquiry: Enquiry!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UITextView!
    @IBOutlet weak var emailLabel: UITextView!    
    @IBOutlet weak var enqLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        dateLabel.text = enquiry.timestamp
        nameLabel.text = enquiry.name
        if let phone = enquiry.phone {
            phoneLabel.text = phone
        }
        emailLabel.text = enquiry.email
        enqLabel.text = enquiry.enquiry
        BackendController.shared.updateEnquiry(enquiry: enquiry)
         */
        
        dateLabel.text = dynamicEnquiry.timestamp
        nameLabel.text = dynamicEnquiry.name
        if let phone = dynamicEnquiry.phone {
            phoneLabel.text = phone
        }
        emailLabel.text = dynamicEnquiry.email
        enqLabel.text   = dynamicEnquiry.enquiry
        if self.dynamicEnquiry.viewed != true {
            BackendController.shared.markEnquiryAsRead(dynamicEnquiry.id) { (bool) in
                if bool == true
                {
                    self.dynamicEnquiry.viewed = true
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
