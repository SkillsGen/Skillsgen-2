//
//  BookingViewController.swift
//  Skillsgen
//
//  Created by Sebastian Reinolds on 20/12/2017.
//  Copyright © 2017 Sebastian Reinolds. All rights reserved.
//

import UIKit

class BookingViewController: UIViewController {

    var booking: Booking?
    
    @IBOutlet weak var label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label?.text = booking!.course
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
