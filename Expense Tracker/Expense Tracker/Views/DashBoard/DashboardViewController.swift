//
//  DashboardViewController.swift
//  Expense Tracker
//
//  Created by Andy Nguyen on 29/11/21.
//

import UIKit

class DashboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func presentAddNewRecordScreen(_ sender: Any) {
        self.showAddNewRecordScreen()
    }
    
    func showAddNewRecordScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "NewRecordViewController")  as! NewRecordViewController
        viewController.modalPresentationStyle = UIModalPresentationStyle.popover
        self.present(viewController, animated: true, completion: nil)
        
    }
}
