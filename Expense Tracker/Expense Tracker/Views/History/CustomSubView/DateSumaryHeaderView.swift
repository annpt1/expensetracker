//
//  DateSumaryHeaderView.swift
//  Expense Tracker
//
//  Created by Andy Nguyen on 4/12/21.
//

import UIKit

class DateSumaryHeaderView: UIView {

    @IBOutlet weak var sumAmountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "DateSumaryHeaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    func updateHeaderValue(expenseDetail: Date, sumAmount: Double) {
        self.dateLabel.text = expenseDetail.toStringWithEdMMMFormat()
        self.sumAmountLabel.text = String(format: "$%.2f", sumAmount)
    }

}
