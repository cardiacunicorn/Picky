//
//  Recipe.swift
//  Picky
//
//  Created by Alex Mills on 08/10/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//

struct Recipe {
    
    // public variables, rather than getters
    var id:Int
    var title:String
    var readyTime:Int
    var servings:Int
    var imageName:String
    var cuisines:[Cuisine]
    var diets:[Diet]
    var instructions:String
    var ingredients:[String]
    
    
    init    (id:Int = 404,
            title:String,
            readyTime:Int,
            servings:Int = 1,
            imageName:String,
            cuisines:[Cuisine] = [],
            diets:[Diet] = [],
            instructions:String = "",
            ingredients:[String] = []) {
        self.id = id
        self.title = title
        self.readyTime = readyTime
        self.servings = servings
        self.imageName = imageName
        self.cuisines = cuisines
        self.diets = diets
        self.instructions = instructions
        self.ingredients = ingredients
    }

    // Returns Recipe details to console
    var summary:String {
        // Shortened compared to Guest version of summary
        return "ID: \(id)\nRecipe: \(title), serves \(servings)\nCuisine(s): \(cuisines)\nDiet(s): \(diets)\nReady Time: \(readyTime)\nIngredients:\n\t\(ingredients)\nInstructions:\n\t\(instructions)"
    }
}
