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
    
    @IBAction func deleteButton(_ sender: UIButton) {
        // ISSUE: I need to pass my function the cell's index path, but don't have access to it
        // self.viewModel.removeGuest(byIndex: indexPath)
        self.tableView.reloadData()
    }
    @IBAction func createGuestButton(_ sender: UIBarButtonItem) {
        createGuestAlert()
    }
    
    var guestID:Int = 5
    var newGuest:String = ""
    var groups:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "guestCell", for: indexPath)
        
        // Find elements within the TableView
        let guestName = cell.viewWithTag(1020) as? UILabel
        let guestGroups = cell.viewWithTag(1021) as? UILabel
        let guestDelete = cell.viewWithTag(1022) as? UIButton
        
        if let guestName = guestName, let guestGroups = guestGroups, let guestDelete = guestDelete {
            let currentGuest = viewModel.getGuest(byIndex: indexPath.row)
            guestName.text = currentGuest.name
            guestGroups.text = currentGuest.groups.joined(separator: ", ")
            // TODO: Implement a delete solution
            // guestDelete.addTarget(self, action: deleteButton(UIButton.self), for: .touchUpInside)
        }

        return cell
    }
    
    func createGuestAlert() {
        // Create controller
        let alertController = UIAlertController(title: "Create Guest", message: "Enter guest's name, and any comma-separated group(s) they should be added to", preferredStyle: .alert)
        // Generate textFields for user input
        alertController.addTextField {
            (textField) in textField.placeholder = "Enter name"
        }
        alertController.addTextField {
            (textField) in textField.placeholder = "Enter group(s) e.g. Friends,Family"
        }
        // Create add & cancel options
        let createGuest = UIAlertAction(title: "Create", style: .default) { (_) in
            let name = alertController.textFields?[0].text
            let groupsInput = alertController.textFields?[1].text
            self.newGuest = name ?? "New Guest, ID:\(self.guestID)"
            // Split user group(s) input, by comma, into an array -- default an empty array
            self.groups = groupsInput?.components(separatedBy: ",") ?? []
            self.viewModel.addGuest(newGuest:
                Guest(id:self.guestID,
                      name: self.newGuest,
                      groups: self.groups,
                      diets: [],
                      allergies: []
            ))
            print("User created a new guest named '\(self.newGuest)', with ID \(self.guestID)")
            self.tableView.reloadData()
            self.guestID += 1
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
