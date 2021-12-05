//
//  ExpenseDetails+CoreDataClass.swift
//  Expense Tracker
//
//  Created by Andy Nguyen on 1/12/21.
//
//

import Foundation
import CoreData

@objc(ExpenseDetails)
public class ExpenseDetails: NSManagedObject {
    func amoundInString() -> String {
        return String(self.amount)
    }
}
