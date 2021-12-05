//
//  DashBoardModel.swift
//  Expense Tracker
//
//  Created by Andy Nguyen on 29/11/21.
//

import UIKit

class DashBoardModel: NSObject {
    func getDataForSpendingTrend() -> [Double] {
        var result = [Double]()
        let expensesOnLast7days = DataManager.shared.getDaysOfExpenses(fromDate: Date(), numberOfDaysRecords: 7)
        let sumSpendingEachDay = expensesOnLast7days.map { items in
            return items.reduce(0) { partialResult, record in
                return partialResult + record.amount
            }
        }
        //Reversed data with olded records first.
        result = sumSpendingEachDay.reversed()
        return result
    }
    
    func getDataForPieChartCategoryTrend() -> [String : Double] {
        let result = DataManager.shared.getExpensesByCategoryOnLast(fromDate: Date(), numberOfDays: 7)
        return result
    }
    
        
    func getSumExpenseOfMonth(date:Date) -> Double {
        let startDate = date.startOfMonth()
        let endDAte = date.endOfMonth()
        let records = DataManager.shared.fetchExpenseFromPeriod(startDate: startDate, endDate: endDAte)
        let result = records.reduce(0) { partialResult, record in
            return partialResult + record.amount
        }
        return result
    }
    
    func getSpendComparisionWithPreviousMonth(dateOfThisMonth:Date) -> Double {
        let sumExpenseOfThisMonth = self.getSumExpenseOfMonth(date: dateOfThisMonth)
        guard let dateOfLastMonth = dateOfThisMonth.getPreviousMonth() else { return 0 }
        let sumExpenseOfLastMonth = self.getSumExpenseOfMonth(date: dateOfLastMonth)
        let gap = (sumExpenseOfThisMonth - sumExpenseOfLastMonth) / sumExpenseOfLastMonth * 100
        return gap
    }
    
    //Return copy and color in tupple (Copy: String, Color: UIColor)
    func getComparisionWithLastMonthCopy(date:Date) -> (String, UIColor) {
        let gap = self.getSpendComparisionWithPreviousMonth(dateOfThisMonth: date)
        if gap > 0 {
            return ("spent \(Int(gap))% more compared to last month",Theme.shared.redHighlight)
        } else {
            return ("spend \(abs(Int(gap)))% less compared to last month",Theme.shared.subtextOnLightBackgroundColor)
        }
    }
}
