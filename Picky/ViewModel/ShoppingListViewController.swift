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

    @IBAction func addItemButton(_ sender: Any) {
        // Triggered when the user taps the + button
    }
    @IBAction func inputField(_ sender: Any) {
        // Triggered when the user finishes editing their input
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        // let table = viewWithTag(1011) as? UITableView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingItem", for: indexPath)

        // Configure the cell...
        
        let listItem = cell.viewWithTag(1010) as? UIButton
        
        if let listItem = listItem {
            let currentItem = viewModel.getItem(byIndex: indexPath.row)
            print(currentItem)
            listItem.titleLabel?.text = currentItem
        }

        return cell
    }
}
