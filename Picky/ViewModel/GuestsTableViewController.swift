//
//  GuestsTableViewController.swift
//  Picky
//
//  Created by Alex Mills on 20/10/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//

import UIKit

class GuestsTableViewController: UITableViewController {

    private var viewModel = GuestsViewModel()
    
    @IBAction func createGuestButton(_ sender: UIBarButtonItem) {
        createGuestAlert()
    }
    
    var newGuest = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "guestCell", for: indexPath)

        // Configure the cell...

        return cell
    }
    
    func createGuestAlert() {
        // Create controller
        let alertController = UIAlertController(title: "Create Guest", message: "Enter guest's name", preferredStyle: .alert)
        // Generate textField for user input
        alertController.addTextField {
            (textField) in textField.placeholder = "Enter name"
        }
        // Create add & cancel options
        let createGuest = UIAlertAction(title: "Create", style: .default) { (_) in
            let item = alertController.textFields?[0].text
            self.newGuest = item ?? "New Guest"
            print("User created a new guest named '\(self.newGuest)'")
        }
        let cancelCreate = UIAlertAction(title: "Cancel", style: .cancel) { (_) in print("User cancelled their action to create a new guest") }
        
        // Append options to the alert controller
        alertController.addAction(createGuest)
        alertController.addAction(cancelCreate)
        
        self.present(alertController, animated: true, completion: nil)
    }

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
