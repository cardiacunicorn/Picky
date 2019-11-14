//
//  ShoppingListViewController.swift
//  Picky
//
//  Created by Alex Mills on 18/10/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//

import UIKit

class ShoppingListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var viewModel = ShoppingViewModel.shared
    private var newItem:String = ""
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func addItemAction(_ sender: UIBarButtonItem) {
        addItemAlert()
    }
    @IBAction func editMenuButton(_ sender: Any) {
        if (tableView.isEditing) {
            tableView.setEditing(false, animated: true)
        } else {
            tableView.setEditing(true, animated: true)
        }
    }
    @IBAction func editItemButton(_ sender: Any) {
        editItem()
        self.tableView.reloadData()
    }
    @IBAction func itemTextButton(_ sender: Any) {
        // Intentionally treated as if user intends to cross off the shopping list item
        // Unintended side effect is that default scrolling behaviour seems glitchy when click-dragging on text because default behaviour is suppressed
        markItem()
        self.tableView.reloadData()
    }
    @IBAction func itemCheckbox(_ sender: Any) {
        markItem()
        self.tableView.reloadData()
    }

    // ISSUE: Not currently used or working as intended
    @IBAction func inputField(_ sender: Any) {
        // Triggered when the user finishes editing their input
        print("User typed in something")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Tells the TableView this file will be its delegate & datasource
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.tableView.reloadData()
        print("View appears. Shopping List Count: \(viewModel.count)")
    }
    
    func addItemAlert() {
        // Create controller
        let alertController = UIAlertController(title: "Add Item", message: "Enter an item to add to your list", preferredStyle: .alert)
        // Generate textField for user input
        alertController.addTextField {
            (textField) in textField.placeholder = "Enter item"
        }
        // Create add & cancel options
        let addItem = UIAlertAction(title: "Add", style: .default) { (_) in
            let item = alertController.textFields?[0].text
            self.newItem = item ?? "New item"
            self.viewModel.addItem(newItem: self.newItem)
            self.tableView.reloadData()
        }
        let cancelAdd = UIAlertAction(title: "Cancel", style: .cancel) { (_) in print("User cancelled their action to add to the shopping list") }
        
        // Append options to the alert controller
        alertController.addAction(addItem)
        alertController.addAction(cancelAdd)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func markItem() {
        // TODO: check or uncheck, strikethrough or remove strikethrough
    }
    
    func editItem() {
        tableView.setEditing(true, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            viewModel.removeItem(byIndex: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingItem", for: indexPath) as UITableViewCell
        let listItem = cell.viewWithTag(1010) as? UIButton

        if let listItem = listItem {
            let currentItem = viewModel.getItem(byIndex: indexPath.row)
            // ISSUE: Prototype cells are generated, but title labels do not update until user scrolls the cell offscreen
            // SOLUTION: Needed to use setTitle function, not direct edit of text e.g. listItem.titleLabel?.text
            listItem.setTitle(currentItem, for: UIControl.State.normal)
        }

        return cell
    }
}
