//
//  BookingTableViewCell.swift
//  Skillsgen
//
//  Created by Sebastian Reinolds on 20/12/2017.
//  Copyright © 2017 Sebastian Reinolds. All rights reserved.
//

import UIKit

class BookingTableViewCell: UITableViewCell {

    @IBOutlet weak var dayOfMonthLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var customerLabel: UILabel!
    @IBOutlet weak var noOfDelegatesLabel: UILabel!
    @IBOutlet weak var trainerLabel: UILabel!
    
    let cellDateFormatter = DateFormatter()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
