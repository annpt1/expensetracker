//
//  HistoryViewController.swift
//  Expense Tracker
//
//  Created by Andy Nguyen on 29/11/21.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension HistoryViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
