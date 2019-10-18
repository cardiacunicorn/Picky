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
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    // ISSUE: This function does not appear to run before the view is loaded
    // Consider whether preparing for a segue from the TabBar may help
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingItem", for: indexPath)

        let listItem = cell.viewWithTag(1010) as? UIButton

        if let listItem = listItem {
            let currentItem = viewModel.getItem(byIndex: indexPath.row)
            listItem.titleLabel?.text = currentItem
        }

        return cell
    }
}
