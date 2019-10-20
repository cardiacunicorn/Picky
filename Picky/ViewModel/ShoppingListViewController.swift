//
//  ShoppingListViewController.swift
//  Picky
//
//  Created by Alex Mills on 18/10/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//

import UIKit

class ShoppingListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let viewModel = ShoppingViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func addItemButton(_ sender: Any) {
        // Triggered when the user taps the + button
    }
    @IBAction func inputField(_ sender: Any) {
        // Triggered when the user finishes editing their input
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Tells the TableView this file will be its delegate & datasource
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // ISSUE: TableView data only appearing after the View loads, requiring a refresh or scroll. Neither of the below appear to work.
//        tableView.reloadData()
//        self.tableView.reloadData()
        
        // Editable, multiple selection for checkbox functionality
        tableView.setEditing(true, animated: false)
        tableView.allowsMultipleSelection = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    // ISSUE: This function does not appear to run before the view is loaded
    // Consider whether preparing for a segue from the TabBar may help
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingItem", for: indexPath) as UITableViewCell

        let listItem = cell.viewWithTag(1010) as? UIButton

        if let listItem = listItem {
            let currentItem = viewModel.getItem(byIndex: indexPath.row)
            print(currentItem)
            listItem.titleLabel?.text = currentItem
        }
        
        // self.tableView.reloadData()
        
        // self.tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)

        return cell
    }
}
