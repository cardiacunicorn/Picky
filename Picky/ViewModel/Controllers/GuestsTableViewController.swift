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
    @IBAction func editGuestButton(_ sender: Any) {
        viewModel.editGuest()
        self.tableView.reloadData()
    }
    @IBAction func minusGuestButton(_ sender: UIButton) {
        if let cell = sender.superview?.superview as? UITableViewCell {
            if let guest = cell.viewWithTag(1020) as? UILabel {
                guard let guestName = guest.text else { return }
                viewModel.removeGuest(guestName)
            }
        }
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        viewModel.loadData()
        self.tableView.reloadData()
        print("Guestlist opened. ActiveGuests/Total: [\(viewModel.count)/\(viewModel.totalGuests)]")
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
        
        if let guestName = guestName, let guestGroups = guestGroups {
            let currentGuest = viewModel.getGuest(byIndex: indexPath.row)
            guestName.text = currentGuest.name
            guestGroups.text = currentGuest.guestlists.joined(separator: ", ")
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            viewModel.deleteGuest(byIndex: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    func createGuestAlert() {
        var grouplists:[String] = []
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
            guard let name = alertController.textFields?[0].text else {return}
            let grouplistsInput = alertController.textFields?[1].text
            // Split user group(s) input, by comma, into an array -- default an empty array
            grouplists = grouplistsInput?.components(separatedBy: ",") ?? []
            // Remove leading and trailing spaces
            for var grouplist in grouplists {
                grouplist = grouplist.trimmingCharacters(in: .whitespaces)
            }
            self.viewModel.addGuest(name, [], [], grouplists)
            self.tableView.reloadData()
        }
        let cancelCreate = UIAlertAction(title: "Cancel", style: .cancel) { (_) in print("User cancelled their action to create a new guest") }
        
        // Append options to the alert controller
        alertController.addAction(createGuest)
        alertController.addAction(cancelCreate)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
