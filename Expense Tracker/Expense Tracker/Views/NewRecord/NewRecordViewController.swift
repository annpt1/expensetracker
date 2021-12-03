//
//  NewRecordViewController.swift
//  Expense Tracker
//
//  Created by Andy Nguyen on 29/11/21.
//

import UIKit

class NewRecordViewController: UIViewController {
    
    let sampleCats = DataManager.shared.getAllExpenseCategory()
    var selectedExpenseCategory : ExpenseType?
    @IBOutlet weak var categoryTypeCollectionView: UICollectionView!
    @IBOutlet weak var inputTextView: UITextField!
    
    @IBOutlet weak var contentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addDoneButtonOnKeyboard()
        self.customView()
    }
    
    private func customView() {
        self.contentView.layer.cornerRadius = 10
        self.categoryTypeCollectionView.layer.cornerRadius = 10
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.inputTextView.becomeFirstResponder()
        self.categoryTypeCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .left)
    }
    
    private func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.valueInputDone))
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        self.inputTextView.inputAccessoryView = doneToolbar
    }
    
    @objc private func valueInputDone()
    {
        self.submitRecord()
        self.inputTextView.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func submitRecord() {
        guard let valueStr = self.inputTextView.text else { return }
        guard let value = Double(valueStr) else { return }
        guard let selectedExpenseCategory = selectedExpenseCategory else { return }
        if value > 0 {
            DataManager.shared.addNewExpenseRecord(amount: value, descriptions: "Test", category:selectedExpenseCategory )
        }
    }
    
}


extension NewRecordViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sampleCats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.categoryTypeCollectionView.dequeueReusableCell(withReuseIdentifier: ExpenseCategoryCollectionViewCell.identifier, for: indexPath) as! ExpenseCategoryCollectionViewCell
        cell.categoryLabel.text = self.sampleCats[indexPath.item].title()
        cell.categoryLogoLabel.text = self.sampleCats[indexPath.item].logo()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedExpenseCategory = self.sampleCats[indexPath.row]
    }
    
}
