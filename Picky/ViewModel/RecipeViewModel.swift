//
//  RecipeViewModel.swift
//  Picky
//
//  Created by Alex Mills on 10/10/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//

import UIKit

// responsible for manipulating the data of the model, model just represents
// getting ready for the view
// may transform or filter, getting ready for view

struct RecipeViewModel {
    
    // temp set to array values due to failure of loadData()
    private (set) var recipes:[Recipe] = []
    
    let placeholder = UIImage(named: "tomato-basil-pasta")
    
    // returns the number of recipes
    var count:Int {
        return recipes.count
    }
    
    // loads a bunch of placeholder recipes
    private mutating func loadData() {
        recipes.append(recipe1)
        recipes.append(recipe2)
        recipes.append(recipe3)
        recipes.append(recipe4)
        recipes.append(recipe5)
    }
    
    init() {
        loadData()
    }
    
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
        
        // this is where the image should be created from the filename
        let image = UIImage(named: recipes[index].imageName)
        // not currently being returned
        
        return (id, title, readyTime, servings, imageName, image ?? placeholder!, cuisines, diets, instructions, ingredients)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // Some selected placeholder recipe data from the Spoonacular API
    var recipe1 = Recipe(id:950595,title:"Instant Pot Acorn Squash Stuffed with Cranberries, Wild Rice, and Chickpeas",readyTime:60,servings:6,imageName:"acorn-squash",cuisines:[Cuisine.French],diets:[Diet.Vegan],instructions:"Bring 1 1/2 cups water to a boil in a small saucepan. Add the rice and 1/2 teaspoon kosher salt. Reduce heat to low, cover, and let simmer until the rice is tender, about 55 minutes. Drain off any excess liquid. Set aside.Pour 1/2 cup water into the bottom of an Instant Pot or electric pressure cooker. Place the steamer basket in the pot, then add the squash, cut sides up (they will overlap). Be sure not to exceed the max fill line. If your squash are larger and you exceed the line, cook the squash in two batches. Seal the lid, set pressure valve to sealing, and cook on HIGH (manual) for 4 minutes. Allow the pressure to release naturally for 5 minutes, then immediately vent to release any remaining pressure. Drain and arrange on a large serving plate or baking sheet.Meanwhile, heat the olive oil in a large skillet over medium low. Add the shallot and cook until softened, about 4 minutes. Add the garlic and cook 30 seconds until fragrant, then add the mushrooms, black pepper, and remaining 1/2 teaspoon kosher salt. Increase heat to medium and cook until the mushrooms are softened and browned, about 5 to 7 additional minutes. Add the chickpeas, cranberries, pepitas, thyme, and cooked rice and stir to heat through, about 2 additional minutes. Taste and adjust seasonings as desired.Spoon the hot filling into the squash halves. Serve immediately or keep warm in a 350 degree F oven.",ingredients:["Kosher Salt","Rice","Olive Oil","Shallots","Garlic","Pumpkin Seeds"])

    var recipe2 = Recipe(id:762330,title:"Pasta with Fresh Tomatoes, Basil and Roasted Garlic",readyTime:45,servings:4,imageName:"tomato-basil-pasta",cuisines:[Cuisine.Italian],diets:[Diet.Vegan,Diet.Vegetarian],instructions:"",ingredients:["Tomato","Basil","Garlic","Pasta"])

    var recipe3 = Recipe(id:760634,title:"Apple-Oat Bars",readyTime:45,servings:16,imageName:"apple-oat-bars",cuisines:[Cuisine.American],diets:[Diet.Vegan],instructions:"Preheat oven to 350F. Lightly grease 9-inch square baking pan, or coat with nonstick cooking spray.Mix flour, oats, brown sugar, baking powder, salt, cinnamon and nutmeg in mixing bowl. Using fork or fingertips, work in oil and cider until mixture resembles coarse crumbs.  Press about 1 1/2 cups oat mixture firmly into bottom of prepared pan. Sprinkle with apples. Mix walnuts into remaining oat mixture, sprinkle evenly over apples and pat into even layer.Bake 30 to 35 minutes, or until top is golden and apples are tender when pierced with a fork. Cool completely on a wire rack before cutting into bars. ",ingredients:["Apple","Oats","Cinnamon","Salt","Nutmeg"])

    var recipe4 = Recipe(id:250693,title:"Coconut Pecan Fudge Frosting",readyTime:30,servings:8,imageName:"coconut-pecan-fudge-frosting",cuisines:[Cuisine.American],diets:[Diet.Vegan,Diet.Pescatarian],instructions:"Whisk rice milk, cornstarch and salt in a small bowl.In a large, stainless-steel saucepan over medium heat, stir together the coconut milk and brown sugar.Cook, stirring occasionally, until mixture starts to boil. Turn down heat to low and cook, stirring occasionally, for 5 minutes.Whisk the rice-milk mixture once more, and slowly pour into the coconut-milk mixture, stirring constantly to incorporate.Stir mixture continuously, until it darkens, gets very thick and smooth, and cornstarch is cooked, about 6 to 7 minutes.Remove from heat and beat in vanilla and bourbon, chopped pecans and coconut.Stir until everything is coated and completely combined.Cool to room temperature before frosting cupcakes.",ingredients:["Desecated Coconut","Pecans","Rice Milk","Brown Sugar"])

    var recipe5 = Recipe(id:459325,title:"Rainbow Roasted Pepper Soup",readyTime:45,servings:2,imageName:"roasted-pepper-soup",cuisines:[Cuisine.Spanish],diets:[Diet.Vegan,Diet.Vegetarian],instructions:"Preheat oven to 375 degrees F (190 degrees C) , halve all peppers (remove seeds)  and peel garlic.                            Place halved peppers, cut side up in shallow baking dish.  Place one garlic clove in each half and squeeze lemon juice generously over peppers. Roast for 1 hour.                            Meanwhile pour vegetable broth into a 2 quart sauce pan and add fennel seeds.  Bring to boil, cover and simmer.                            When peppers are done, remove from oven and set aside to cool.  When cool enough to touch peel skin from peppers.                            Strain fennel seeds from broth and return to a boil.  Add thyme and simmer 15 minutes, reducing amount of broth.                            Slice a 1 inch section from each color of pepper and cut into pieces.  Set aside for later garnishing.                            In a blender, place remaining peppers, garlic  and a 1/2 cup broth on blend just long enough to shred the peppers, but not puree them.  You want to see the different colors.  Pour the blended peppers into the broth and stir well.  Add garlic salt and black pepper to taste, then add garnishing pepper pieces and enjoy.  Do not boil or cook any longer as the colors will fade.                                                Kitchen-Friendly View",ingredients:["Peppers","Garlic","Fennel Seeds"])
    

    
}
