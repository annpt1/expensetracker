//
//  ExpenseCategoryCollectionViewCell.swift
//  Expense Tracker
//
//  Created by Andy Nguyen on 29/11/21.
//

import UIKit

class ExpenseCategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    static let identifier = "ExpenseCategoryCollectionViewCell"
    
    override var isSelected: Bool {
        didSet{
            if self.isSelected {
                UIView.animate(withDuration: 0.3) { // for animation effect
                     self.backgroundColor = UIColor(red: 115/255, green: 190/255, blue: 170/255, alpha: 1.0)
                }
            }
            else {
                UIView.animate(withDuration: 0.3) { // for animation effect
                     self.backgroundColor = UIColor(red: 60/255, green: 63/255, blue: 73/255, alpha: 1.0)
                }
            }
        }
    }
}
