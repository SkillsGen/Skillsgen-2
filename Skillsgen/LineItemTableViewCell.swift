//
//  LineItemTableViewCell.swift
//  Skillsgen
//
//  Created by Sebastian Reinolds on 21/12/2017.
//  Copyright © 2017 Sebastian Reinolds. All rights reserved.
//

import UIKit

class LineItemTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var unitPriceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalWithVat: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
