//
//  NewRecordViewController.swift
//  Expense Tracker
//
//  Created by Andy Nguyen on 29/11/21.
//

import UIKit

class NewRecordViewController: UIViewController {
    
    let sampleCats = ["Transport","Foods","Groceries","Utilities","Shopping","Services"]
    var selectedCat = ""
    @IBOutlet weak var categoryTypeCollectionView: UICollectionView!
    @IBOutlet weak var inputTextView: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addDoneButtonOnKeyboard()
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
        self.inputTextView.resignFirstResponder()
    }
    
}


extension NewRecordViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sampleCats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.categoryTypeCollectionView.dequeueReusableCell(withReuseIdentifier: ExpenseCategoryCollectionViewCell.identifier, for: indexPath) as! ExpenseCategoryCollectionViewCell
        cell.categoryLabel.text = self.sampleCats[indexPath.item]
        if self.selectedCat == self.sampleCats[indexPath.item] {
            cell.backgroundColor = UIColor.darkGray
        } else {
            cell.backgroundColor = UIColor.clear
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
