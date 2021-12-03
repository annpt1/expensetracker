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
    
    @IBOutlet weak var categoryLogoLabel: UILabel!
    
    override var isSelected: Bool {
        didSet{
            if self.isSelected {
                UIView.animate(withDuration: 0.3) { // for animation effect
                    self.categoryLabel.textColor = UIColor(red: 115/255, green: 190/255, blue: 170/255, alpha: 1.0)
                    self.categoryLogoLabel.textColor = UIColor(red: 115/255, green: 190/255, blue: 170/255, alpha: 1.0)
                }
            }
            else {
                UIView.animate(withDuration: 0.3) { // for animation effect
                    self.categoryLabel.textColor = UIColor.darkText
                    self.categoryLogoLabel.textColor = UIColor.darkText

                }
            }
        }
    }
}
