//
//  OrderViewController.swift
//  Skillsgen
//
//  Created by Sebastian Reinolds on 21/12/2017.
//  Copyright © 2017 Sebastian Reinolds. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    var order: Order?
    var booking: Booking?
    
    @IBOutlet weak var lineItemsTableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let lineItems = order?.lineItems {
            return lineItems.count
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LineItemCell", for: indexPath) as! LineItemTableViewCell
        
        let lineItem = order!.lineItems![indexPath.row]
        
        cell.descriptionLabel.text = lineItem.description
        cell.unitPriceLabel.text = "£" + String(lineItem.unitPrice)
        cell.quantityLabel.text = String(lineItem.quantity)
        cell.totalLabel.text = "£" + String(lineItem.net)
        
        if lineItem.vat {
            cell.totalWithVat.text = "£" + String(lineItem.total)
        } else {
            cell.totalWithVat.text = "No VAT"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "LineItems:"
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var customerLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var orderSentLabel: UILabel!
    @IBOutlet weak var orderConfirmedLabel: UILabel!
    @IBOutlet weak var orderInvoicedLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    
    @IBOutlet weak var totalPlusVatLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        addressLabel.text = order?.address
        contactLabel.text = order?.contact
        customerLabel.text = order?.customer
        courseLabel.text = booking?.course
        dateLabel.text = dateFormatter.string(from: booking!.date)
        totalPlusVatLabel.text = "Total+VAT: £" + String(order!.total)
        totalLabel.text = "Total: £" + String(order!.totalWithVat)
        notesLabel.text = order?.notes ?? ""
        
        if order!.sent {
            orderSentLabel.text = "Order Sent ✔︎"
            orderSentLabel.textColor = .green
        } else {
            orderSentLabel.text = "Order not sent"
        }
        
        if order!.confirmed {
            orderConfirmedLabel.text = "Order confirmed ✔︎"
            orderConfirmedLabel.textColor = .green
        } else {
            orderConfirmedLabel.text = "Order not confirmed"
        }
        
        if order!.invoiced {
            orderInvoicedLabel.text = "Order Invoiced ✔︎"
            orderInvoicedLabel.textColor = .green
        } else {
            orderInvoicedLabel.text = "Order not Invoiced"
        }
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
