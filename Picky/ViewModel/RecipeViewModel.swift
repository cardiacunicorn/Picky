//
//  RecipeViewModel.swift
//  Picky
//
//  Created by Alex Mills on 10/10/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//

import UIKit
import Foundation

class RecipeViewModel {
    
    private let apiKey:String = "apiKey=1bc139cbc4374d598695a4ba1160ab17"
    private let endpoint:String = "https://api.spoonacular.com/recipes/random?"
    private var query:String = ""
    private var request = Request.shared
    var delegate:Refresh? {
        get {
            return request.delegate
        }
        set(value) {
            request.delegate = value
        }
    }
    
    var recipes:[Recipe] {
        return request.recipes
    }
    
    let placeholder = UIImage(named: "placeholder")
    
    init() {
        // Initialise the request query for recipes data
        
        // STOP REQUESTS TO API
        // getRecipes()
    }
    
    func getRecipes() {
        request.getRecipe(number:8)
    }
    
    // returns the number of recipes
    var count:Int {
        return recipes.count
    }
    
    // returns the titles of current recipes for troubleshooting
    var summary: String {
        var result = ""
        for recipe in recipes {
            result.append("\(recipe.id): \(recipe.title)\n")
        }
        return result
    }
    
    // convenience getters, rather than making variables public
    func getID(index:Int) -> Int {
        return recipes[index].id
    }
    
    func getTitle(index:Int) -> String {
        return recipes[index].title
    }
    
    func getIngredients(index:Int) -> [String] {
        return recipes[index].ingredients
    }
    
    func getInstructions(index:Int) -> String {
        return recipes[index].instructions
    }
    
    func getServings(index:Int) -> Int {
        return recipes[index].servings
    }
    
    func getReadyTime(index:Int) -> Int {
        return recipes[index].readyTime
    }
    
    func getCuisines(index:Int) -> [Cuisine] {
        return recipes[index].cuisines
    }
    
    func getDiets(index:Int) -> [Diet] {
        return recipes[index].diets
    }
    
    func getImage(index:Int) -> UIImage {
        var image = placeholder
        if let imageURL = URL(string: recipes[index].imageName) {
            if let imageData = try? Data(contentsOf: imageURL) {
                image = UIImage(data: imageData)
            }
        }
        return image ?? placeholder!
    }
    
    
    // this function should no longer be required
    func getRecipe(byIndex index:Int) -> (id:Int, title:String, readyTime:Int, servings:Int, imageName:String, image:UIImage ,cuisines:[Cuisine], diets:[Diet], instructions:String, ingredients:[String]) {
        let id = recipes[index].id
        let title = recipes[index].title
        let readyTime = recipes[index].readyTime
        let servings = recipes[index].servings
        let imageName = recipes[index].imageName
        let cuisines = recipes[index].cuisines
        let diets = recipes[index].diets
        let instructions = recipes[index].instructions
        let ingredients = recipes[index].ingredients
        
        var image = placeholder
        if let imageURL = URL(string: imageName) {
            if let imageData = try? Data(contentsOf: imageURL) {
                image = UIImage(data: imageData)
            }
        }
        
        return (id, title, readyTime, servings, imageName, image ?? placeholder!, cuisines, diets, instructions, ingredients)
    }
    
}
