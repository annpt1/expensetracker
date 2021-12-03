//
//  HistoryViewController.swift
//  Expense Tracker
//
//  Created by Andy Nguyen on 29/11/21.
//

import UIKit
import UIScrollView_InfiniteScroll

class HistoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var expenseList = [[ExpenseDetails]]()
    var expenseRecordsByDate = [String:[ExpenseDetails]]()
    var dateOfLastRecord = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoadDate()
        self.tableView.addInfiniteScroll { (_) in
            self.initialLoadDate()
            self.tableView.finishInfiniteScroll { tableView in
                tableView.reloadData()
            }
        }
        self.tableView.reloadData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.expenseList = DataManager.shared.fetchExpenseFromDate(startDate: Date(), numberOfRecords: 5)
//        self.expenseList = DataManager.shared.fetchAllExpenses(nil, nil, nil)
//        self.expenseList = DataManager.shared.fetchAllExpensesOnDate(date: Date())
//        self.expenseRecordsByDate = self.groupingExpenseByDate(expenses: self.expenseList)
    }
    
    func initialLoadDate() {
        let limit = 20
        var result = 0
        let lastRecordsData = DataManager.shared.fetchExpenseBeforeDate(startDate: dateOfLastRecord, numberOfRecords: 1)
        guard let lastRecord = lastRecordsData.first else { return }
        guard let dateFromLastRecord = lastRecord.date else { return }
        self.dateOfLastRecord = dateFromLastRecord
        while result < limit {
            let data = DataManager.shared.fetchAllExpensesOnDate(date: dateOfLastRecord)
            result += data.count
            if data.isEmpty {
                return
            }
            self.expenseList.append(data)
            dateOfLastRecord = dateOfLastRecord.dateByAddingMore(days: -1)
        }
        self.tableView.finishInfiniteScroll()

    }
    
    func loadMore() {
        
    }
    
    func groupingExpenseByDate(expenses:[ExpenseDetails]) -> [String:[ExpenseDetails]] {
        var result = [String:[ExpenseDetails]]()
        for item in expenses {
            if let key = item.date?.toStringWithDDMMMYYYYFormat(){
                if var list = result[key] {
                    list.append(item)
                } else {
                    result[key] = [item]
                }
                
            }
        }
        return result
    }

}

extension HistoryViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(expenseList.count)
        return expenseList[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ExpenseHistoryTableViewCell", for: indexPath) as! ExpenseHistoryTableViewCell
        cell.amountLabel.text = "$"+String(expenseList[indexPath.section][indexPath.row].amount)
        if let date = expenseList[indexPath.section][indexPath.row].date {
            cell.dateLabel.text = date.toStringWithhhmmFormat()
        }
        if let category = ExpenseType.init(rawValue: Int(expenseList[indexPath.section][indexPath.row].category))  {
            cell.categoryLabel.text = category.logo()
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.expenseList.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let recordForDate = self.expenseList[section].first {
            return recordForDate.date?.toStringWithDDMMMYYYYFormat()
        }
        return nil
    }
}
