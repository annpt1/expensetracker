//
//  View+Extension.swift
//  Expense Tracker
//
//  Created by Andy Nguyen on 4/12/21.
//

import UIKit

extension UIView {
    func addGradient(fromColor:UIColor, toColor:UIColor) {
        let gradient = CAGradientLayer()

        gradient.frame = self.bounds
        gradient.colors = [fromColor, toColor]

        self.layer.insertSublayer(gradient, at: 0)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
