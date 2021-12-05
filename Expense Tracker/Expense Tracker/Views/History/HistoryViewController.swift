//
//  HistoryViewController.swift
//  Expense Tracker
//
//  Created by Andy Nguyen on 29/11/21.
//

import UIKit
import UIScrollView_InfiniteScroll

class HistoryViewController: UIViewController, BaseViewProtocol {

    @IBOutlet weak var tableView: UITableView!
    private var viewModel : HistoryModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViewModel()
        self.tableView.addInfiniteScroll { (_) in
            self.loadMore()
            self.tableView.finishInfiniteScroll { tableView in
                tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.dateOfLastRecord = Date()
        initialLoadData()
    }
    
    func setUpViewModel() {
        self.viewModel = HistoryModel()
    }
    
    func customUI() {
        //NA
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.viewModel.clearData()
        self.tableView.reloadData()
    }
    
    private func initialLoadData() {
        self.viewModel.initialLoadData()
        self.tableView.reloadData()
    }

    
    private func loadMore() {
        self.viewModel.loadMoreDataForDisplay()
        self.tableView.finishInfiniteScroll()
    }

}

extension HistoryViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.expensesData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ExpenseHistoryTableViewCell", for: indexPath) as! ExpenseHistoryTableViewCell
        let expenseDetails = self.viewModel.expensesData[indexPath.section][indexPath.row]
        cell.updateDetails(expenseDetails: expenseDetails)
        cell.selectionStyle = .none
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.expensesData.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = DateSumaryHeaderView.instanceFromNib() as! DateSumaryHeaderView
        guard let headerData = viewModel.getDataForHeader(section: section) else  { return nil }
        view.updateHeaderValue(expenseDetail:headerData.0 ,sumAmount: headerData.1)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let recordForDate = self.viewModel.expensesData[section].first {
            return recordForDate.date?.toStringWithDDMMMYYYYFormat()
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let expenseDetails = self.viewModel.expensesData[indexPath.section][indexPath.row]
            DataManager.shared.removeExpenseRecord(record: expenseDetails)
            self.viewModel.expensesData[indexPath.section].remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
}
