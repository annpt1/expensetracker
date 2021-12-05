//
//  NewRecordViewController.swift
//  Expense Tracker
//
//  Created by Andy Nguyen on 29/11/21.
//

import UIKit

protocol NewRecordViewControllerDelegate : AnyObject {
    func newRecordAdded()
}

class NewRecordViewController: UIViewController, BaseViewProtocol, UITextFieldDelegate {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var currentInputValueLabel: UILabel!
    @IBOutlet weak var expenseDescriptionsTextField: UITextField!
    @IBOutlet weak var categoryTypeCollectionView: UICollectionView!
    
    weak var delegate : NewRecordViewControllerDelegate?
    var viewModel : NewRecordModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViewModel()
        self.customUI()
    }
    
    func setUpViewModel() {
        self.viewModel = NewRecordModel()
    }
    
    func customUI() {
        self.contentView.layer.cornerRadius = 10
        self.categoryTypeCollectionView.layer.cornerRadius = 10
        self.contentView.backgroundColor = Theme.shared.chartBackgroundColor
        currentInputValueLabel.textColor = Theme.shared.selectedItemColor
        currentInputValueLabel.layer.cornerRadius = 7
        currentInputValueLabel.clipsToBounds = true
        
        //Set Default expense category
        categoryTypeCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .left)
        viewModel.userDidSelectExpenseCategory(expenseCategory: viewModel.expenseCategory[0])

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func tappedOnBlankSpace(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func userDidSelectedRecordDate(_ sender: Any) {
        viewModel.selectedDate = self.datePicker.date
    }
    
    @IBAction func inputKeyTapped(_ sender: Any) {
        let tag = (sender as! UIButton).tag
        viewModel.expenseDescription = expenseDescriptionsTextField.text
        if viewModel.userAddedInput(tag: tag) {
            delegate?.newRecordAdded()
            self.dismiss(animated: true, completion: nil)
        }
        self.currentInputValueLabel.text = viewModel.outputStr
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}


extension NewRecordViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.expenseCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.categoryTypeCollectionView.dequeueReusableCell(withReuseIdentifier: ExpenseCategoryCollectionViewCell.identifier, for: indexPath) as! ExpenseCategoryCollectionViewCell
        cell.updateCategoryData(expenseCategory: viewModel.expenseCategory[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.userDidSelectExpenseCategory(expenseCategory: viewModel.expenseCategory[indexPath.row])
    }
    
}
