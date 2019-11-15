//
//  ShoppingCartViewController.swift
//  Picky
//
//  Created by Alex Mills on 18/10/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//

import UIKit

class ShoppingCartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var viewModel = ShoppingCartViewModel.shared
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
    @IBAction func itemCheckbox(_ sender: Any) {
        // TODO: check or uncheck, strikethrough or remove strikethrough
        // Q: Do I send sender as a parameter of the function so it knows which item should be updated?
        viewModel.markItem()
        self.tableView.reloadData()
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
            guard let item = alertController.textFields?[0].text else {return}
            self.viewModel.addItem(newItem: item)
            self.viewModel.addCartItem(item)
            self.tableView.reloadData()
        }
        let cancelAdd = UIAlertAction(title: "Cancel", style: .cancel) { (_) in print("User cancelled their action to add to the shopping list") }
        
        // Append options to the alert controller
        alertController.addAction(addItem)
        alertController.addAction(cancelAdd)
        
        self.present(alertController, animated: true, completion: nil)
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
        let listItem = cell.viewWithTag(1010) as? UILabel

        if let listItem = listItem {
            let currentItem = viewModel.getItem(byIndex: indexPath.row)
            listItem.text = currentItem.name
        }

        return cell
    }
}
