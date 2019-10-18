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
        print("Shopping List has loaded and is being viewed.")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Anyone home?")
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Code is not reaching this point
        
        print("Anyone home?")
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingItem", for: indexPath)
        
        let listItem = cell.viewWithTag(1010) as? UIButton
        print(listItem?.titleLabel?.text)
        
        if let listItem = listItem {
            let currentItem = viewModel.getItem(byIndex: indexPath.row)
            listItem.titleLabel?.text = currentItem
        }

        return cell
    }
}
