//
//  ExpenseHistoryTableViewCell.swift
//  Expense Tracker
//
//  Created by Andy Nguyen on 1/12/21.
//

import UIKit

class ExpenseHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var expenseDescriptions: UILabel!
    
    func updateDetails(expenseDetails:ExpenseDetails) {
        self.amountLabel.text = String(format: "$%.2f", expenseDetails.amount)
        if let date = expenseDetails.date {
            self.dateLabel.text = date.toStringWithHHmmFormat()
        }
        if let category = ExpenseType.init(rawValue: Int(expenseDetails.category))  {
            self.categoryLabel.text = category.logo()
        }
        self.expenseDescriptions.text = expenseDetails.descriptions
    }

}
