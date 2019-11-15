//
//  RecipeDetailViewController.swift
//  Picky
//
//  Created by Alex Mills on 18/10/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    // ISSUE: No default scrolling behaviour in detail view -> mainly affects landscape view

    var selectedRecipe:(id: Int, title: String, readyTime: Int, servings: Int, imageName: String, image: UIImage?, cuisines: [Cuisine], diets: [Diet], instructions: String, ingredients: [String])?
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailReadyTime: UILabel!
    @IBOutlet weak var detailTags: UILabel!
    @IBOutlet weak var detailIngredients: UILabel!
    @IBOutlet weak var detailInstructions: UILabel!
    
    @IBAction func addAllButton(_ sender: Any) {
        print("Adding all ingredients to user's shopping cart")
        if let allIngredients = selectedRecipe?.ingredients {
            for ingredient in allIngredients {
                // Add the ingredient to the Shopping Cart in CoreData
                CartItemsManager.shared.addCartItem(ingredient, detailTitle.text ?? "None")
                // Now need to let the Cart ViewModel that it should update it's data
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let selectedRecipe = selectedRecipe{
            detailTitle.text = selectedRecipe.title
            detailReadyTime.text = " " + String(selectedRecipe.readyTime) + "m "
            detailImage.image = selectedRecipe.image
            detailIngredients.text = ""
            for ingredient in selectedRecipe.ingredients {
                detailIngredients.text?.append(ingredient+"\n")
            }
            detailInstructions.text = selectedRecipe.instructions
            
        }
    }
}
