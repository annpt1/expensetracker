//
//  DataManager.swift
//  Expense Tracker
//
//  Created by Andy Nguyen on 30/11/21.
//

import UIKit

enum ExpenseType : Int {
    case Transport
    case Food
    case Groceries
    case Bills
    case Shopping
    case Services
}

extension ExpenseType {
    func logo() -> String {
        switch self {
        case .Food:
            return ""
        case .Transport:
            return ""
        case .Groceries:
            return ""
        case .Bills:
            return ""
        case .Shopping:
            return ""
        case .Services:
            return ""
        }
    }
    
    func title() -> String {
        switch self {
        case .Food:
            return "Food"
        case .Transport:
            return "Transport"
        case .Groceries:
            return "Groceries"
        case .Bills:
            return "Bills"
        case .Shopping:
            return "Shopping"
        case .Services:
            return "Services"
        }
    }
}

struct ExpenseModel {
    let type : ExpenseType
    let amount: Double
    let memo : String
}

class DataManager: NSObject {
    static let shared = DataManager()
    private let dbContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let expenseCategory : [ExpenseType] = [.Transport,.Food,.Shopping,.Services,.Groceries,.Bills]
    
    func addNewExpenseRecord(amount: Double, descriptions: String, category: ExpenseType) {
        let newExpense = ExpenseDetails(context: dbContext)
        newExpense.amount = amount
        newExpense.category = Int16(category.rawValue)
        newExpense.descriptions = descriptions
//        newExpense.date = Date().addingTimeInterval(-381400)
        newExpense.date = Date()
        self.saveChangesOnDB()
    }
    
    func removeExpenseRecord(record:ExpenseModel) {
        
    }
    
    func fetchAllExpenses(_ predicate:NSPredicate?, _ sortDescriptor: [NSSortDescriptor]?, _ fetchLimit: Int?) -> [ExpenseDetails] {
        var result = [ExpenseDetails]()
        do {
            let expenseFetchRequest = ExpenseDetails.fetchRequest()
            if let predicate = predicate {
                expenseFetchRequest.predicate = predicate
            }
            if let sortDescriptor = sortDescriptor {
                expenseFetchRequest.sortDescriptors = sortDescriptor
            } else {
                expenseFetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(ExpenseDetails.date), ascending: false)]
            }
            if let fetchLimit = fetchLimit {
                expenseFetchRequest.fetchLimit = fetchLimit
            }

            result = try dbContext.fetch(expenseFetchRequest)
        } catch {
            print("Cannot fetch expenses")
        }
        return result
    }
    
    func fetchExpenseFromPeriod(startDate:Date,endDate:Date) -> [ExpenseDetails] {
        let predicate = NSPredicate(format: "date >= %@ AND date < %@", startDate as NSDate, endDate as NSDate)
        let sort = NSSortDescriptor(key: #keyPath(ExpenseDetails.date), ascending: false)
        return self.fetchAllExpenses(predicate,[sort],nil)
    }
    
    func fetchExpenseFromDate(startDate:Date,numberOfRecords:Int) -> [ExpenseDetails] {
        let predicate = NSPredicate(format: "date >= %@", startDate as NSDate)
        let sort = NSSortDescriptor(key: #keyPath(ExpenseDetails.date), ascending: false)
        return self.fetchAllExpenses(predicate,[sort],numberOfRecords)
    }
    
    func fetchExpenseBeforeDate(startDate:Date,numberOfRecords:Int) -> [ExpenseDetails] {
        let predicate = NSPredicate(format: "date <= %@", startDate as NSDate)
        let sort = NSSortDescriptor(key: #keyPath(ExpenseDetails.date), ascending: false)
        return self.fetchAllExpenses(predicate,[sort],numberOfRecords)
    }
    
    func fetchAllExpensesOnDate(date:Date) -> [ExpenseDetails] {
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        let startDate = calendar.startOfDay(for: date)
        guard let endDate = calendar.date(byAdding: .day, value: 1, to: startDate) else { return [] }
        let predicate = NSPredicate(format: "date >= %@ AND date < %@", startDate as NSDate, endDate as NSDate)
        return self.fetchAllExpenses(predicate,nil,nil)
    }
        
    func saveChangesOnDB() {
        do {
            try self.dbContext.save()
        } catch {
            print("Error saving data")
        }
    }
    
    func getAllExpenseCategory() -> [ExpenseType] {
        return self.expenseCategory
    }

}
