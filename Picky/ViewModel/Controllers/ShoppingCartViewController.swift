//
//  ShoppingCartViewController.swift
//  Picky
//
//  Created by Alex Mills on 18/10/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//

import UIKit

class ShoppingCartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var viewModel = ShoppingCartViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func addItemAction(_ sender: UIBarButtonItem) {
        addItemAlert()
    }
    @IBAction func trashMenuButton(_ sender: Any) {
        // Removes all items from CoreData and active memory
        viewModel.clearAllItems()
        tableView.reloadData()
    }
    @IBAction func editItemButton(_ sender: Any) {
        // viewModel.editItem()
        tableView.reloadData()
    }
    @IBAction func itemCheckbox(_ sender: UIButton) {
        // Retrieve and parse the parent cell of the checkbox
        if let cell = sender.superview?.superview as? UITableViewCell {
            toggleChecked(cell)
        }
    }
    
    func toggleChecked(_ cell:UITableViewCell) {
        if let cellLabel = cell.viewWithTag(1010) as? UILabel {
            // Toggling text label being enabled for style changes, as enabled state isn't used currently
            cellLabel.isEnabled = !cellLabel.isEnabled
            if let itemName = cellLabel.text {
                viewModel.toggleChecked(itemName)
            }
        }
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Tells the TableView this file will be its delegate & datasource
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        viewModel.loadCartItems()
        self.tableView.reloadData()
        print("View appears. Shopping Cart Count: \(viewModel.count)")
    }
    
    func addItemAlert() {
        // Create controller
        let alertController = UIAlertController(title: "Add Item", message: "Enter an item to add to your cart", preferredStyle: .alert)
        // Generate textField for user input
        alertController.addTextField {
            (textField) in textField.placeholder = "Enter item"
        }
        // Create add & cancel options
        let addItem = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let item = alertController.textFields?[0].text else {return}
            self.viewModel.addItem(item)
            self.tableView.reloadData()
        }
        let cancelAdd = UIAlertAction(title: "Cancel", style: .cancel) { (_) in print("User cancelled their action to add to the shopping cart") }
        
        // Append options to the alert controller
        alertController.addAction(addItem)
        alertController.addAction(cancelAdd)
        
        self.present(alertController, animated: true, completion: nil)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartItem", for: indexPath) as UITableViewCell
        let itemTitle = cell.viewWithTag(1010) as? UILabel
        let itemCheckbox = cell.viewWithTag(1011) as? UIButton

        if let itemTitle = itemTitle, let itemCheckbox = itemCheckbox {
            let currentItem = viewModel.getItem(byIndex: indexPath.row)
            itemTitle.text = currentItem.name
            // Checked items are disabled, not selected, for default styling effect
            itemTitle.isEnabled  = !currentItem.checked
            itemCheckbox.isSelected = currentItem.checked
        }

        return cell
    }
}
