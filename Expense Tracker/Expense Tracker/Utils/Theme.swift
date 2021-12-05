//
//  Theme.swift
//  Expense Tracker
//
//  Created by Andy Nguyen on 3/12/21.
//

import Foundation
import UIKit


class Theme : NSObject {
    static let shared = Theme()
    
    let whiteColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    let blackColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    let chartBackgroundColor = UIColor(red: 0.616, green: 0.714, blue: 0.875, alpha: 1)
    let dashboardScreenBackgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    let textOnDarkBackgroundColor = UIColor(hue: 0, saturation: 0, brightness: 1, alpha: 1.0) /* #ffffff */
    let textOnLightBackgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)/* #01070b */
    let subtextOnLightBackgroundColor = UIColor(red: 0.478, green: 0.549, blue: 0.627, alpha: 1)
    let highlightText = UIColor(red: 0.446, green: 0.733, blue: 0.704, alpha: 1)
    let textOnLightBackgroundColor1 = UIColor(hue: 0.5667, saturation: 0.9, brightness: 0.04, alpha: 1.0) /* #01070b */
    let textOnLightBackgroundColor2 = UIColor(hue: 0.5667, saturation: 0.9, brightness: 0.04, alpha: 1.0) /* #01070b */
    let textOnLightBackgroundColor3 = UIColor(hue: 0.5667, saturation: 0.9, brightness: 0.04, alpha: 1.0) /* #01070b */
    let textOnLightBackgroundColor4 = UIColor(hue: 0.5667, saturation: 0.9, brightness: 0.04, alpha: 1.0)
    let textOnLightBackgroundColor5 = UIColor(hue: 0.5667, saturation: 0.9, brightness: 0.04, alpha: 1.0)
    let buttonColor = UIColor(red: 0.314, green: 0.663, blue: 0.827, alpha: 1)
    let selectedItemColor = UIColor(red: 0.971, green: 0.564, blue: 0.429, alpha: 1)
    let unselectedItemColor = UIColor(red: 0.478, green: 0.549, blue: 0.627, alpha: 1)
    let pieChartColorSet = [UIColor(red: 0.827, green: 0.89, blue: 0.988, alpha: 1) ,UIColor(red: 0.645, green: 0.745, blue: 0.9, alpha: 1), UIColor(red: 0.486, green: 0.622, blue: 0.833, alpha: 1),UIColor(red: 0.727, green: 0.757, blue: 0.804, alpha: 1), UIColor(red: 0.364, green: 0.521, blue: 0.767, alpha: 1),UIColor(red: 0.486, green: 0.581, blue: 0.733, alpha: 1)]
    
    let redHighlight = UIColor(red: 1, green: 0.325, blue: 0.325, alpha: 1)
    func customAppUI() {
        UITabBar.appearance().tintColor = Theme.shared.chartBackgroundColor

    }
}
