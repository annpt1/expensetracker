//
//  HistoryModel.swift
//  Expense Tracker
//
//  Created by Andy Nguyen on 29/11/21.
//

import UIKit

class HistoryModel: NSObject {
    
    var expensesData = [[ExpenseDetails]]()
    var dateOfLastRecord = Date()

    func clearData() {
        self.expensesData.removeAll()
    }
    
    func initialLoadData() {
        self.expensesData = DataManager.shared.getDaysOfExpenses(fromDate:self.dateOfLastRecord, numberOfDaysRecords: 6)
    }
    
    func getDataForLast3Days() {
        
    }
    
    func loadMoreDataForDisplay() {
        guard let lastDateList = self.expensesData.last, let lastRecord = lastDateList.last ,let lastDate = lastRecord.date else { return }
        let nextDateRecords = DataManager.shared.getDaysOfExpenses(fromDate: lastDate, numberOfDaysRecords: 3)
        expensesData.append(contentsOf: nextDateRecords)
    }
    
    func getDataForHeader(section:Int) -> (Date,Double)? {
        guard let expenseDetails = self.expensesData[section].first else { return nil }
        let sumOnDate = self.expensesData[section].reduce(0) { partialResult, item in
            return partialResult + item.amount
        }
        guard let date = expenseDetails.date else { return nil }
        return (date,sumOnDate)
    }
}
