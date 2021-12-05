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
    
    func defaultDescriptions() -> String {
        switch self {
        case .Food:
            return "Luch/Dinner"
        case .Transport:
            return "Bus/Taxi"
        case .Groceries:
            return "Rice/Meat/Veggie"
        case .Bills:
            return "Electric/Water/Internet"
        case .Shopping:
            return "Self care"
        case .Services:
            return "Self care"
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
    
    func addNewExpenseRecord(amount: Double, descriptions: String, category: ExpenseType, onDate: Date) {
        let newExpense = ExpenseDetails(context: dbContext)
        newExpense.amount = amount
        newExpense.category = Int16(category.rawValue)
        newExpense.descriptions = descriptions
        newExpense.date = onDate
        self.saveChangesOnDB()
    }
    
    func removeExpenseRecord(record:ExpenseDetails) {
        dbContext.delete(record)
        self.saveChangesOnDB()
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
    
    func fetchExpenseBeforeDate(nonIncludedDate:Date,numberOfRecords:Int) -> [ExpenseDetails] {
        let predicate = NSPredicate(format: "date < %@", nonIncludedDate as NSDate)
        let sort = NSSortDescriptor(key: #keyPath(ExpenseDetails.date), ascending: false)
        return self.fetchAllExpenses(predicate,[sort],numberOfRecords)
    }
    
    func fetchExpenseBeforeDate(includedDate:Date,numberOfRecords:Int) -> [ExpenseDetails] {
        let predicate = NSPredicate(format: "date <= %@", includedDate as NSDate)
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
    
    func fetchAllExpensesOnMonth(date:Date) -> [ExpenseDetails] {
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        let startDate = calendar.startOfDay(for: date)
        guard let endDate = calendar.date(byAdding: .day, value: 1, to: startDate) else { return [] }
        let predicate = NSPredicate(format: "date >= %@ AND date < %@", startDate as NSDate, endDate as NSDate)
        return self.fetchAllExpenses(predicate,nil,nil)
    }
    
        
    private func saveChangesOnDB() {
        do {
            try self.dbContext.save()
        } catch {
            print("Error saving data")
        }
    }
    
    func getAllExpenseCategory() -> [ExpenseType] {
        return self.expenseCategory
    }
    
    func getDaysOfExpenses(fromDate:Date, numberOfDaysRecords:Int) -> [[ExpenseDetails]] {
        var searchDate = fromDate
        var result = [[ExpenseDetails]]()
        guard let nextRecordDate = self.getNextDateWithRecord(afterDate: searchDate) else { return result }
        searchDate = nextRecordDate
        while result.count < numberOfDaysRecords {
            let data = DataManager.shared.fetchAllExpensesOnDate(date: searchDate)
            result.append(data)
            guard let currentLastRecordDate = data.last!.date else { return result }
            guard let nextDateWithRecord = DataManager.shared.getNextDateWithRecord(afterDate: currentLastRecordDate) else { return result }
            searchDate = nextDateWithRecord
        }
        return result
    }
    
    func getNextDateWithRecord(afterDate:Date) -> Date? {
        let lastRecordsData = DataManager.shared.fetchExpenseBeforeDate(nonIncludedDate: afterDate, numberOfRecords: 1)
        guard let lastRecord = lastRecordsData.first, let dateOfNextRecord = lastRecord.date else { return nil }
        return dateOfNextRecord
    }
    
    func getExpensesByCategoryOnLast(fromDate: Date = Date(), numberOfDays:Int) -> [String:Double] {
        var result = [String:Double]()
        let daysOfExpenses = self.getDaysOfExpenses(fromDate: fromDate, numberOfDaysRecords: numberOfDays)
        for day in daysOfExpenses {
            for item in day {
                guard let expenseCate = ExpenseType.init(rawValue: Int(item.category)) else { continue }
                result[expenseCate.title()] = result[expenseCate.title()] ?? 0 + item.amount
            }
        }
        return result
    }
    
    func generateSampleData() {
        let numberOfDays = 14
        for i in 1...numberOfDays {
            for _ in 0...Int.random(in:1..<7) {
                guard let randomExpenseType = ExpenseType(rawValue: Int.random(in: 0..<6)) else { return }
                self.addNewExpenseRecord(amount: Double.random(in: 0.5..<18), descriptions: "Sample Record", category: randomExpenseType, onDate: Date().dateByAddingMore(days: -i))
            }
        }
    }

}
