//
//  RecipeTableViewController.swift
//  Picky
//
//  Created by Alex Mills on 17/10/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//

import UIKit

// unsure whether these VC's need to be reduced to structs, I'm sure they'll want to be inheriting some sort of functionality
class RecipeTableViewController: UITableViewController {

    // the link to the ViewModel
    private let viewModel = RecipeViewModel()
    
    
    // **** Cocoa Touch Class Methods **** //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Asks the data source for a cell to insert in a particular location of the table view
        let cell = tableView.dequeueReusableCell(withIdentifier: "protoCell", for: indexPath)
        
        print("Success")
        
        // Find elements within the table view
        let imageView = cell.viewWithTag(1001) as? UIImageView
        let recipeTitle = cell.viewWithTag(1000) as? UILabel
        let recipeTags = cell.viewWithTag(1002) as? UILabel
        
        
        cell.textLabel?.text = String(indexPath.item + 1)
        
        
//        // Check elements were found
//        if let imageView = imageView, let recipeTitle = recipeTitle, let recipeTags = recipeTags {
//
//            // Run some code
//            print("Safely found views with tags, confirmed class, and unpacked")
//            print("\(recipeTitle.text): \(recipeTags.text)")
//
//            // Tute 5.3 - 18min
//            // currently only runs safely while sample data exceeds numberOfRowsInSection below
//            // let currentRecipe = viewModel.getRecipe(byIndex: indexPath.row)
//            let currentRecipe = viewModel.getRecipe(byIndex: 1)
//            print(currentRecipe)
//
//            // imageView.image = currentRecipe.image
//        }
        
        
        return cell
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//        guard let selectedRow = self.tableView.indexPathForSelectedRow else {return}
//        let destination = segue.destination // as? Custom class for Detail view controller
//        let recipeSelected = viewModel.recipes[selectedRow.row]
//        destination!.recipeSelected = recipeSelected
//    }
}
