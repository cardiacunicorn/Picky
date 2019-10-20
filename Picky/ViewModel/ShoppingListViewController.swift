//
//  ShoppingListViewController.swift
//  Picky
//
//  Created by Alex Mills on 18/10/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//

import UIKit

class ShoppingListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var viewModel = ShoppingViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func addItemButton(_ sender: Any) {
        // Triggered when the user taps the + button
        print("User tapped")
        
        // Update Array
        viewModel.addItem(newItem: "New Shopping Item")
        
        // Update Table Data
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: (viewModel.count)-1, section: 0)], with: UITableView.RowAnimation.automatic)
        tableView.endUpdates()
        tableView.reloadData()
    }
    @IBAction func inputField(_ sender: Any) {
        // Triggered when the user finishes editing their input
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Tells the TableView this file will be its delegate & datasource
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Editable, multiple selection for checkbox functionality
        // tableView.setEditing(true, animated: false)
        tableView.allowsMultipleSelection = true
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
