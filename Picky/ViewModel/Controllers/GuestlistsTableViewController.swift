//
//  GuestsTableViewController.swift
//  Picky
//
//  Created by Alex Mills on 21/10/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//

import UIKit

class GuestlistsTableViewController: UITableViewController {

    private var viewModel = GuestlistsViewModel()
    
    @IBAction func createGuestlistButton(_ sender: Any) {
        createGuestlistAlert()
    }
    @IBAction func editMenuButton(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        viewModel.loadData()
        self.tableView.reloadData()
        print("Guestlists tab opened. Guestlists count: \(viewModel.count)")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "guestlistCell", for: indexPath)
        
        // Find elements within the TableView
        let guestlistName = cell.viewWithTag(1020) as? UILabel
        let guestlistAllergies = cell.viewWithTag(1021) as? UILabel
        
        if let guestlistName = guestlistName, let guestlistAllergies = guestlistAllergies {
            let currentGuestlist = viewModel.getGuestlist(byIndex: indexPath.row)
            guestlistName.text = currentGuestlist.name
            
            // guestlistAllergies.text = currentGuestlist.allergies.joined(separator: ", ")
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            viewModel.deleteGuestlist(byIndex: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    func createGuestlistAlert() {
        // Create controller
        let alertController = UIAlertController(title: "Create Guestlist", message: "Enter guest's name, and any comma-separated group(s) they should be added to", preferredStyle: .alert)
        // Generate textFields for user input
        alertController.addTextField {
            (textField) in textField.placeholder = "Enter name"
        }
        // Create add & cancel options
        let createGuestlist = UIAlertAction(title: "Create", style: .default) { (_) in
            guard let name = alertController.textFields?[0].text else {return}
            self.viewModel.addGuestlist(name)
            self.tableView.reloadData()
        }
        let cancelCreate = UIAlertAction(title: "Cancel", style: .cancel) { (_) in print("User cancelled their action to create a new guestlist") }
        
        // Append options to the alert controller
        alertController.addAction(createGuestlist)
        alertController.addAction(cancelCreate)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue.destination)
        // if sender is UITableViewCell
        // Refer it's index, so it can set the global active guestlist index
    }
}
