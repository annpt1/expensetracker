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
            self.setColorForLabels(self.isSelected)
        }
    }
    
    func setColorForLabels(_ isSelected:Bool) {
        var color = Theme.shared.unselectedItemColor
        if isSelected {
            color = Theme.shared.selectedItemColor
        }
        self.categoryLabel.textColor = color
        self.categoryLogoLabel.textColor = color
    }
    
    func updateCategoryData(expenseCategory:ExpenseType) {
        self.categoryLabel.text = expenseCategory.title()
        self.categoryLogoLabel.text = expenseCategory.logo()
    }
}
