//
//  NewRecordModel.swift
//  Expense Tracker
//
//  Created by Andy Nguyen on 29/11/21.
//

import UIKit

class NewRecordModel: NSObject {

    let expenseCategory = DataManager.shared.getAllExpenseCategory()
    var inputList = [Int]()
    var currentInputToString = ""
    var selectedExpenseCategory : ExpenseType?
    var expenseDescription : String?
    var outputStr = ""
    var selectedDate : Date?
    
    /// return true if record successfully submitted
    func userAddedInput(tag:Int) -> Bool {
        if tag == -5 && self.inputList.last == -5 {
            return false
        } else if tag == -1 {
            //verify input

            if let convertedDoubleInput = Double(currentInputToString) {
                if convertedDoubleInput > 0 {
                    guard let selectedExpenseCategory = selectedExpenseCategory else { return false }
                    var submitExpenseDescriptions = selectedExpenseCategory.defaultDescriptions()
                    if let inputDescription = self.expenseDescription {
                        submitExpenseDescriptions = inputDescription
                    }
                    self.submitRecord(amount: convertedDoubleInput, description: submitExpenseDescriptions, expenseCategory: selectedExpenseCategory)
                    return true
                }
            }
        }
        self.inputList.append(tag)
        currentInputToString = self.updateInputValue(input: self.inputList)
        updateDisplayStrOutput(str: currentInputToString)
        return false
    }
    
    private func updateDisplayStrOutput(str:String) {
        outputStr = "$" + str
    }
    
    private func updateInputValue(input:[Int]) -> String{
        var strOutput = ""
        for item in input {
            if Array(0...9).contains(where: { number in
                return number == item
            }) {
                strOutput.append(String(item))
            }
            if item == -2 {
                //remove last char
                if !strOutput.isEmpty {
                    strOutput.removeLast()
                }
            }
            if item == -5 {
                //begin add decimal part
                strOutput.append(".")
            }
        }
        return strOutput
        
    }
    
    func submitRecord(amount:Double,description:String, expenseCategory: ExpenseType) {
        DataManager.shared.addNewExpenseRecord(amount: amount, descriptions: description, category:expenseCategory,onDate: selectedDate ?? Date() )
    }
    
    func userDidSelectExpenseCategory(expenseCategory:ExpenseType) {
        self.selectedExpenseCategory = expenseCategory
    }
}
