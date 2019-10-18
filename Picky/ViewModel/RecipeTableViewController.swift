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
        
        // Find elements within the TableView
        let recipeTitle = cell.viewWithTag(1000) as? UILabel
        let imageView = cell.viewWithTag(1001) as? UIImageView
        let readyTime = cell.viewWithTag(1002) as? UILabel
        let recipeTags = cell.viewWithTag(1003) as? UILabel
        
        if let imageView = imageView, let recipeTitle = recipeTitle, let recipeTags = recipeTags {
            
            let currentRecipe = viewModel.getRecipe(byIndex: indexPath.row)
            
            recipeTitle.text = currentRecipe.title
            imageView.image = currentRecipe.image
            readyTime?.text = " " + String(currentRecipe.readyTime) + "m "
            
            // ISSUE: Correct malformed display of info
            // TODO: Consider making each recipe only contain one cuisine
            recipeTags.text = ""
            for cuisine in currentRecipe.cuisines {
                
                // TODO: generate a pill / tag icon for TableView
                recipeTags.text = recipeTags.text! + cuisine.rawValue
                
            }
        }
        
        
            
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let selectedRow = self.tableView.indexPathForSelectedRow else {return}
        let destination = segue.destination as? RecipeDetailViewController
        let selectedRecipe = viewModel.getRecipe(byIndex: selectedRow.row)
        // let recipeSelected = viewModel.recipes[selectedRow.row]
        destination?.selectedRecipe = selectedRecipe
    }
}
