//
//  RecipeTableViewController.swift
//  Picky
//
//  Created by Alex Mills on 17/10/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//

import UIKit

class RecipeTableViewController: UITableViewController {

    private let viewModel = RecipeViewModel()
    @IBOutlet weak var addRecipeButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        destination?.selectedRecipe = selectedRecipe
    }
}
