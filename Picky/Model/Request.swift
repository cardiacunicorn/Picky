//
//  Request.swift
//  Picky
//
//  Created by Alex Mills on 11/11/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//

import Foundation

protocol Refresh {
    func updateUI()
}

class Request {
    var recipes:[Recipe] = []
    var delegate:Refresh?
    private let session = URLSession.shared
    private let apiKey:String = "apiKey=1bc139cbc4374d598695a4ba1160ab17"
    private let endpoint:String = "https://api.spoonacular.com/recipes/random?"
    var query:String = "&tags="
    var numberParam:Int = 5
    
    private init() {}
    static let shared = Request()
    
    private func updateQuery() {
        let guestlist = GuestsManager.shared.getGuestlists()[GuestsManager.shared.activeGuestlistIndex]
        query = "&tags="
        if let allergies = guestlist.allergies {
            query += allergies.joined(separator: ",")
        }
        if let _ = guestlist.allergies, let _ = guestlist.diets  {
            query += ","
        }
        if let diets  = guestlist.diets {
            query += diets.joined(separator: ",")
        }
        query = query.lowercased()
    }
    
    func getRecipe(number:Int) {
        numberParam = number
        recipes = []
        updateQuery()
        let url = endpoint + apiKey + "&number=" + String(numberParam) + query
        
        // Insurance policy, if users end up being able to vary the queries
        guard let escapedURL = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else { return }
        print("Request URL: \(escapedURL)")
        
        if let escapedURL = URL(string: url) {
            let request = URLRequest(url: escapedURL)
            
            let task = session.dataTask(with: request,
                completionHandler: {
                    data, response, downloadError in
                    
                    print("Data object received from the RequestClass' URL Request: \(String(describing: data))")
                    
                    // Handle URL Request failure
                    if let error = downloadError {
                        print(error)
                    } else {
                        var parsedResult: Any! = nil
                        do {
                            parsedResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                        } catch { print() }
                        let result = parsedResult as! [String:Any]
                        let responseRecipes = result["recipes"]
                        // Loop through each recipe
                        for recipe in responseRecipes as! [[String:Any]] {
                            
                            // Extract key information about the recipe
                            let recipeID = recipe["id"] as! Int
                            let recipeTitle = recipe["title"] as! String
                            
                            let minutes = recipe["readyInMinutes"] as? Int
                            let servings = recipe["servings"] as? Int
                            
                            let instructions = recipe["instructions"] as! String
                            let ingredientsObject = recipe["extendedIngredients"] as! [[String:Any]]
                            var ingredients:[String] = []
                            
                            // Pull out the name, amount & units from each ingredient
                            for ingredient in ingredientsObject as [[String:Any]] {
                                let nameAndAmount = ingredient["originalString"] as! String
                                ingredients.append(nameAndAmount)
                            }
                            
                            let imageURL = recipe["image"] as? String
                            
                            // Create a Recipe object from extracted values
                            let responseRecipe = Recipe(id: recipeID, title: recipeTitle, readyTime: minutes ?? 0, servings: servings ?? 1, imageName: imageURL ?? "Image not found", instructions: instructions, ingredients: ingredients)
                            
                            // Add each recipe to the recipes object
                            self.recipes.append(responseRecipe)
                            print("Recipe #\(recipeID): \(recipeTitle) added. [\(self.recipes.count)/\(number)]")
                        }
                    }
                    DispatchQueue.main.async {
                        print("\(self.recipes.count) piping hot new recipes, ready for display")
                        self.delegate?.updateUI()
                    }
                }
            )
            task.resume()
        }
        return
    }
    
}
