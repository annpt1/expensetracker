//
//  ExpenseDetails+CoreDataProperties.swift
//  Expense Tracker
//
//  Created by Andy Nguyen on 1/12/21.
//
//

import Foundation
import CoreData


extension ExpenseDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExpenseDetails> {
        return NSFetchRequest<ExpenseDetails>(entityName: "ExpenseDetails")
    }

    @NSManaged public var amount: Double
    @NSManaged public var category: Int16
    @NSManaged public var descriptions: String?
    @NSManaged public var date: Date?

}

extension ExpenseDetails : Identifiable {

}
