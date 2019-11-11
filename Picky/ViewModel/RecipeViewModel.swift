//
//  RecipeViewModel.swift
//  Picky
//
//  Created by Alex Mills on 10/10/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//

import UIKit
import Foundation

struct RecipeViewModel {
    
    private let apiKey:String = "apiKey=1bc139cbc4374d598695a4ba1160ab17"
    private let endpoint:String = "https://api.spoonacular.com/recipes/random?"
    private var query:String = ""
    private var recipes:[Recipe] = []
    
    // TEMP
    private var responseRecipes:[Recipe] = []
    
    let placeholder = UIImage(named: "tomato-basil-pasta")
    
    init() {
        loadData()
    }
    
    
    
    // returns the number of recipes
    var count:Int {
        return recipes.count
    }
    
    
    // WORK IN PROGRESS
    private mutating func newLoadRemoteData() {
        let session = URLSession.shared
        query = "&tags=pescatarian,italian,dairy"
        if let url = URL(string: endpoint + apiKey + query) {
            let request = URLRequest(url: url)
            
        }
    }
    
    
    
    // pull recipe data from Spoonacular
    private mutating func loadData() {
        
        // loadRemoteData()
        newLoadRemoteData()
        
        // Store as a generic data object
        let dataObject = exampleResponse.data(using: String.Encoding.utf8)!
        
        // Manipulate the response to a Swift object
        let genericObject = try? JSONSerialization.jsonObject(with: dataObject)
        
        // Split the response into individual recipes
        for (key,value) in genericObject as! [String:[Any]] {
            if key == "recipes" {
                
                // Loop through each recipe
                for recipe in value as! [[String:Any]] {
                    
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
                    
                    // Printing to check validity
                    print("\nRecipe #\(recipeID): \(recipeTitle)\n")
                    print("Ready Time: \(minutes ?? 0) mins")
                    print("Servings: \(servings ?? 1)")
                    print("Image address: \(imageURL ?? "No image")")
                    print("Ingredients: \(ingredients)\n")
                    print("Instructions: \(instructions)\n")
                    
                    // Create a Recipe object from extracted values
                    let responseRecipe = Recipe(id: recipeID, title: recipeTitle, readyTime: minutes ?? 0, servings: servings ?? 1, imageName: imageURL ?? "Image not found", instructions: instructions, ingredients: ingredients)
                    
                    // Add each recipe to the recipes object
                    recipes.append(responseRecipe)
                }
            }
        }
        
        // Save recipes locally
        // print(responseRecipes)
        
    }
    
    
    
    private mutating func loadRemoteData() {
        var parsedResult: Any!
        
        // Query should be determined by the Guest list
        // PLACEHOLDER:
        query = "&tags=pescatarian,italian,dairy"
        
        // Create the URL request, with enpoint, API Key & query
        let session = URLSession.shared
        
        if let url = URL(string: endpoint + apiKey + query) {
            let request = URLRequest(url: url)
            
            // Create and run the task to retrieve JSON data from Spoonacular API
            let task = session.dataTask(with: request,
                completionHandler: {
                    data, response, downloadError in
                    
                    print("Data object from URL Request: \(data)")
                    
                    do {
                        // Manipulate the response to a Swift object
                        parsedResult = try JSONSerialization.jsonObject(with: data!)
                        
                        print("Success: \(String(describing: parsedResult))")
                        
                        
                    } catch {
                        print("JSON Serialisation failed")
                        
                        // Pass in default response as a placeholder for when serialisation fails
                        // ISSUE: Not currently working as intended - something to do with the closure not allowing mutations on self objects
                        
                        // let placeholderData = self.exampleResponse.data(using: String.Encoding.utf8)!
                        // parsedResult = try? JSONSerialization.jsonObject(with: placeholderData)
                    }
                })
            task.resume()
        }
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
        
        var image = placeholder
        if let imageURL = URL(string: imageName) {
            if let imageData = try? Data(contentsOf: imageURL) {
                image = UIImage(data: imageData)
            }
        }
        
        return (id, title, readyTime, servings, imageName, image ?? placeholder!, cuisines, diets, instructions, ingredients)
    }
    
    
    
    mutating func addRecipe(newRecipe:Recipe) {
        recipes.append(newRecipe)
        print("Recipes variable now contains:\n\(recipes)")
    }
    
    
    
    // Placeholder for what a Spoonacular response looks like
    var exampleResponse = """
        {
          "recipes": [{
            "vegetarian": true,
            "vegan": true,
            "glutenFree": true,
            "dairyFree": true,
            "veryHealthy": false,
            "cheap": false,
            "veryPopular": false,
            "sustainable": false,
            "weightWatcherSmartPoints": 4,
            "gaps": "no",
            "lowFodmap": false,
            "ketogenic": false,
            "whole30": false,
            "preparationMinutes": 15,
            "cookingMinutes": 55,
            "sourceUrl": "https://www.wellplated.com/instant-pot-acorn-squash/",
            "spoonacularSourceUrl": "https://spoonacular.com/instant-pot-acorn-squash-stuffed-with-cranberries-wild-rice-and-chickpeas-950595",
            "aggregateLikes": 56,
            "spoonacularScore": 94.0,
            "healthScore": 48.0,
            "creditsText": "Well Plated",
            "sourceName": "Well Plated",
            "pricePerServing": 128.9,
            "extendedIngredients": [{
              "id": 11482,
              "aisle": "Produce",
              "image": "acorn-squash.jpg",
              "consitency": "solid",
              "name": "acorn squash",
              "original": "3 small (1 pound each) acorn squashes, halved lengthwise, stems trimmed, and seeded",
              "originalString": "3 small (1 pound each) acorn squashes, halved lengthwise, stems trimmed, and seeded",
              "originalName": "small each) acorn squashes, halved lengthwise, stems trimmed, and seeded",
              "amount": 3.0,
              "unit": "pound",
              "meta": ["trimmed", "halved lengthwise", "seeded"],
              "metaInformation": ["trimmed", "halved lengthwise", "seeded"],
              "measures": {
                "us": {
                  "amount": 3.0,
                  "unitShort": "lb",
                  "unitLong": "pounds"
                },
                "metric": {
                  "amount": 1.361,
                  "unitShort": "kilogram",
                  "unitLong": "kilograms"
                }
              }
            }, {
              "id": 11266,
              "aisle": "Produce",
              "image": "mushrooms.png",
              "consitency": "solid",
              "name": "baby bella mushrooms",
              "original": "8 ounces baby bella (cremini) mushrooms, finely chopped",
              "originalString": "8 ounces baby bella (cremini) mushrooms, finely chopped",
              "originalName": "baby bella (cremini) mushrooms, finely chopped",
              "amount": 8.0,
              "unit": "ounces",
              "meta": ["finely chopped", "(cremini)"],
              "metaInformation": ["finely chopped", "(cremini)"],
              "measures": {
                "us": {
                  "amount": 8.0,
                  "unitShort": "oz",
                  "unitLong": "ounces"
                },
                "metric": {
                  "amount": 226.796,
                  "unitShort": "g",
                  "unitLong": "grams"
                }
              }
            }, {
              "id": 1002030,
              "aisle": "Spices and Seasonings",
              "image": "pepper.jpg",
              "consitency": "solid",
              "name": "black pepper",
              "original": "1/2 teaspoon black pepper",
              "originalString": "1/2 teaspoon black pepper",
              "originalName": "black pepper",
              "amount": 0.5,
              "unit": "teaspoon",
              "meta": ["black"],
              "metaInformation": ["black"],
              "measures": {
                "us": {
                  "amount": 0.5,
                  "unitShort": "tsps",
                  "unitLong": "teaspoons"
                },
                "metric": {
                  "amount": 0.5,
                  "unitShort": "tsps",
                  "unitLong": "teaspoons"
                }
              }
            }, {
              "id": 16058,
              "aisle": "Canned and Jarred",
              "image": "chickpeas.png",
              "consitency": "solid",
              "name": "canned chickpeas",
              "original": "1 (15-ounce) can reduced-sodium chickpeas, rinsed and drained",
              "originalString": "1 (15-ounce) can reduced-sodium chickpeas, rinsed and drained",
              "originalName": "reduced-sodium chickpeas, rinsed and drained",
              "amount": 15.0,
              "unit": "ounce",
              "meta": ["rinsed", "drained", "reduced-sodium", "canned"],
              "metaInformation": ["rinsed", "drained", "reduced-sodium", "canned"],
              "measures": {
                "us": {
                  "amount": 15.0,
                  "unitShort": "oz",
                  "unitLong": "ounces"
                },
                "metric": {
                  "amount": 425.243,
                  "unitShort": "g",
                  "unitLong": "grams"
                }
              }
            }, {
              "id": 9079,
              "aisle": "Dried Fruits;Produce",
              "image": "dried-cranberries.jpg",
              "consitency": "solid",
              "name": "dried cranberries",
              "original": "1/3 cup reduced-sugar dried cranberries",
              "originalString": "1/3 cup reduced-sugar dried cranberries",
              "originalName": "reduced-sugar dried cranberries",
              "amount": 0.3333333333333333,
              "unit": "cup",
              "meta": ["dried", "reduced-sugar"],
              "metaInformation": ["dried", "reduced-sugar"],
              "measures": {
                "us": {
                  "amount": 0.333,
                  "unitShort": "cups",
                  "unitLong": "cups"
                },
                "metric": {
                  "amount": 78.863,
                  "unitShort": "ml",
                  "unitLong": "milliliters"
                }
              }
            }, {
              "id": 2049,
              "aisle": "Produce;Spices and Seasonings",
              "image": "thyme.jpg",
              "consitency": "solid",
              "name": "fresh thyme leaves",
              "original": "1 tablespoon fresh thyme leaves, chopped",
              "originalString": "1 tablespoon fresh thyme leaves, chopped",
              "originalName": "fresh thyme leaves, chopped",
              "amount": 1.0,
              "unit": "tablespoon",
              "meta": ["fresh", "chopped"],
              "metaInformation": ["fresh", "chopped"],
              "measures": {
                "us": {
                  "amount": 1.0,
                  "unitShort": "Tbsp",
                  "unitLong": "Tbsp"
                },
                "metric": {
                  "amount": 1.0,
                  "unitShort": "Tbsp",
                  "unitLong": "Tbsp"
                }
              }
            }, {
              "id": 11215,
              "aisle": "Produce",
              "image": "garlic.jpg",
              "consitency": "solid",
              "name": "garlic",
              "original": "3 large cloves garlic, minced (about 1 tablespoon)",
              "originalString": "3 large cloves garlic, minced (about 1 tablespoon)",
              "originalName": "large cloves garlic, minced (about",
              "amount": 1.0,
              "unit": "tablespoon",
              "meta": ["minced"],
              "metaInformation": ["minced"],
              "measures": {
                "us": {
                  "amount": 1.0,
                  "unitShort": "Tbsp",
                  "unitLong": "Tbsp"
                },
                "metric": {
                  "amount": 1.0,
                  "unitShort": "Tbsp",
                  "unitLong": "Tbsp"
                }
              }
            }, {
              "id": 1082047,
              "aisle": "Spices and Seasonings",
              "image": "salt.jpg",
              "consitency": "solid",
              "name": "kosher salt",
              "original": "1 teaspoon kosher salt, divided",
              "originalString": "1 teaspoon kosher salt, divided",
              "originalName": "kosher salt, divided",
              "amount": 1.0,
              "unit": "teaspoon",
              "meta": ["divided"],
              "metaInformation": ["divided"],
              "measures": {
                "us": {
                  "amount": 1.0,
                  "unitShort": "tsp",
                  "unitLong": "teaspoon"
                },
                "metric": {
                  "amount": 1.0,
                  "unitShort": "tsp",
                  "unitLong": "teaspoon"
                }
              }
            }, {
              "id": 4053,
              "aisle": "Oil, Vinegar, Salad Dressing",
              "image": "olive-oil.jpg",
              "consitency": "liquid",
              "name": "olive oil",
              "original": "1 tablespoon olive oil",
              "originalString": "1 tablespoon olive oil",
              "originalName": "olive oil",
              "amount": 1.0,
              "unit": "tablespoon",
              "meta": [],
              "metaInformation": [],
              "measures": {
                "us": {
                  "amount": 1.0,
                  "unitShort": "Tbsp",
                  "unitLong": "Tbsp"
                },
                "metric": {
                  "amount": 1.0,
                  "unitShort": "Tbsp",
                  "unitLong": "Tbsp"
                }
              }
            }, {
              "id": 12014,
              "aisle": "Savory Snacks",
              "image": "pumpkin-seeds.jpg",
              "consitency": "solid",
              "name": "pepitas",
              "original": "1/4 cup toasted pepitas or chopped pecans",
              "originalString": "1/4 cup toasted pepitas or chopped pecans",
              "originalName": "toasted pepitas or chopped pecans",
              "amount": 0.25,
              "unit": "cup",
              "meta": ["toasted", "chopped"],
              "metaInformation": ["toasted", "chopped"],
              "measures": {
                "us": {
                  "amount": 0.25,
                  "unitShort": "cups",
                  "unitLong": "cups"
                },
                "metric": {
                  "amount": 59.147,
                  "unitShort": "ml",
                  "unitLong": "milliliters"
                }
              }
            }, {
              "id": 11677,
              "aisle": "Produce",
              "image": "shallots.jpg",
              "consitency": "solid",
              "name": "shallot",
              "original": "1 medium shallot, finely chopped, or 1/2 small yellow onion, finely chopped",
              "originalString": "1 medium shallot, finely chopped, or 1/2 small yellow onion, finely chopped",
              "originalName": "shallot, finely chopped, or 1/2 small yellow onion, finely chopped",
              "amount": 1.0,
              "unit": "medium",
              "meta": ["yellow", "finely chopped"],
              "metaInformation": ["yellow", "finely chopped"],
              "measures": {
                "us": {
                  "amount": 1.0,
                  "unitShort": "medium",
                  "unitLong": "medium"
                },
                "metric": {
                  "amount": 1.0,
                  "unitShort": "medium",
                  "unitLong": "medium"
                }
              }
            }, {
              "id": 20088,
              "aisle": "Pasta and Rice",
              "image": "rice-wild-uncooked.png",
              "consitency": "solid",
              "name": "wild rice",
              "original": "1/2 cup uncooked wild rice (you can also use a brown and wild rice blend like this one)",
              "originalString": "1/2 cup uncooked wild rice (you can also use a brown and wild rice blend like this one)",
              "originalName": "uncooked wild rice (you can also use a brown and wild rice blend like this one)",
              "amount": 0.5,
              "unit": "cup",
              "meta": ["wild", "uncooked", "canned", "(you can also use a brown and rice blend like this one)"],
              "metaInformation": ["wild", "uncooked", "canned", "(you can also use a brown and rice blend like this one)"],
              "measures": {
                "us": {
                  "amount": 0.5,
                  "unitShort": "cups",
                  "unitLong": "cups"
                },
                "metric": {
                  "amount": 118.294,
                  "unitShort": "ml",
                  "unitLong": "milliliters"
                }
              }
            }],
            "id": 950595,
            "title": "Instant Pot Acorn Squash Stuffed with Cranberries, Wild Rice, and Chickpeas",
            "readyInMinutes": 60,
            "servings": 6,
            "image": "https://spoonacular.com/recipeImages/950595-556x370.jpg",
            "imageType": "jpg",
            "cuisines": [],
            "dishTypes": ["side dish"],
            "diets": ["gluten free", "dairy free", "lacto ovo vegetarian", "vegan"],
            "occasions": ["christmas"],
            "winePairing": {},
            "instructions": "Bring 1 1/2 cups water to a boil in a small saucepan. Add the rice and 1/2 teaspoon kosher salt. Reduce heat to low, cover, and let simmer until the rice is tender, about 55 minutes. Drain off any excess liquid. Set aside.Pour 1/2 cup water into the bottom of an Instant Pot or electric pressure cooker. Place the steamer basket in the pot, then add the squash, cut sides up (they will overlap). Be sure not to exceed the max fill line. If your squash are larger and you exceed the line, cook the squash in two batches. Seal the lid, set pressure valve to sealing, and cook on HIGH (manual) for 4 minutes. Allow the pressure to release naturally for 5 minutes, then immediately vent to release any remaining pressure. Drain and arrange on a large serving plate or baking sheet.Meanwhile, heat the olive oil in a large skillet over medium low. Add the shallot and cook until softened, about 4 minutes. Add the garlic and cook 30 seconds until fragrant, then add the mushrooms, black pepper, and remaining 1/2 teaspoon kosher salt. Increase heat to medium and cook until the mushrooms are softened and browned, about 5 to 7 additional minutes. Add the chickpeas, cranberries, pepitas, thyme, and cooked rice and stir to heat through, about 2 additional minutes. Taste and adjust seasonings as desired.Spoon the hot filling into the squash halves. Serve immediately or keep warm in a 350 degree F oven.",
            "analyzedInstructions": [{
              "name": "",
              "steps": [{
                "number": 1,
                "step": "Bring 1 1/2 cups water to a boil in a small saucepan.",
                "ingredients": [],
                "equipment": [{
                  "id": 404669,
                  "name": "sauce pan",
                  "image": "sauce-pan.jpg"
                }]
              }, {
                "number": 2,
                "step": "Add the rice and 1/2 teaspoon kosher salt. Reduce heat to low, cover, and let simmer until the rice is tender, about 55 minutes.",
                "ingredients": [{
                  "id": 1082047,
                  "name": "kosher salt",
                  "image": "salt.jpg"
                }],
                "equipment": [],
                "length": {
                  "number": 55,
                  "unit": "minutes"
                }
              }, {
                "number": 3,
                "step": "Drain off any excess liquid. Set aside.",
                "ingredients": [],
                "equipment": []
              }, {
                "number": 4,
                "step": "Pour 1/2 cup water into the bottom of an Instant Pot or electric pressure cooker.",
                "ingredients": [],
                "equipment": [{
                  "id": 404658,
                  "name": "pressure cooker",
                  "image": "pressure-cooker.jpg"
                }, {
                  "id": 414093,
                  "name": "instant pot",
                  "image": ""
                }]
              }, {
                "number": 5,
                "step": "Place the steamer basket in the pot, then add the squash, cut sides up (they will overlap). Be sure not to exceed the max fill line. If your squash are larger and you exceed the line, cook the squash in two batches. Seal the lid, set pressure valve to sealing, and cook on HIGH (manual) for 4 minutes. Allow the pressure to release naturally for 5 minutes, then immediately vent to release any remaining pressure.",
                "ingredients": [],
                "equipment": [{
                  "id": 404767,
                  "name": "steamer basket",
                  "image": "steamer.jpg"
                }, {
                  "id": 404752,
                  "name": "pot",
                  "image": "stock-pot.jpg"
                }],
                "length": {
                  "number": 9,
                  "unit": "minutes"
                }
              }, {
                "number": 6,
                "step": "Drain and arrange on a large serving plate or baking sheet.Meanwhile, heat the olive oil in a large skillet over medium low.",
                "ingredients": [{
                  "id": 4053,
                  "name": "olive oil",
                  "image": "olive-oil.jpg"
                }],
                "equipment": [{
                  "id": 404727,
                  "name": "baking sheet",
                  "image": "baking-sheet.jpg"
                }, {
                  "id": 404645,
                  "name": "frying pan",
                  "image": "pan.png"
                }]
              }, {
                "number": 7,
                "step": "Add the shallot and cook until softened, about 4 minutes.",
                "ingredients": [{
                  "id": 11677,
                  "name": "shallot",
                  "image": "shallots.jpg"
                }],
                "equipment": [],
                "length": {
                  "number": 4,
                  "unit": "minutes"
                }
              }, {
                "number": 8,
                "step": "Add the garlic and cook 30 seconds until fragrant, then add the mushrooms, black pepper, and remaining 1/2 teaspoon kosher salt. Increase heat to medium and cook until the mushrooms are softened and browned, about 5 to 7 additional minutes.",
                "ingredients": [{
                  "id": 1002030,
                  "name": "black pepper",
                  "image": "pepper.jpg"
                }, {
                  "id": 1082047,
                  "name": "kosher salt",
                  "image": "salt.jpg"
                }, {
                  "id": 11215,
                  "name": "garlic",
                  "image": "garlic.png"
                }],
                "equipment": []
              }, {
                "number": 9,
                "step": "Add the chickpeas, cranberries, pepitas, thyme, and cooked rice and stir to heat through, about 2 additional minutes. Taste and adjust seasonings as desired.Spoon the hot filling into the squash halves.",
                "ingredients": [{
                  "id": 12014,
                  "name": "pumpkin seeds",
                  "image": "pumpkin-seeds.jpg"
                }, {
                  "id": 2049,
                  "name": "thyme",
                  "image": "thyme.jpg"
                }],
                "equipment": []
              }, {
                "number": 10,
                "step": "Serve immediately or keep warm in a 350 degree F oven.",
                "ingredients": [],
                "equipment": [{
                  "id": 404784,
                  "name": "oven",
                  "image": "oven.jpg",
                  "temperature": {
                    "number": 350.0,
                    "unit": "Fahrenheit"
                  }
                }]
              }]
            }]
          }, {
            "vegetarian": true,
            "vegan": true,
            "glutenFree": false,
            "dairyFree": true,
            "veryHealthy": false,
            "cheap": false,
            "veryPopular": false,
            "sustainable": false,
            "weightWatcherSmartPoints": 7,
            "gaps": "no",
            "lowFodmap": false,
            "ketogenic": false,
            "whole30": false,
            "sourceUrl": "http://www.vegetariantimes.com/recipe/pasta-with-fresh-tomatoes-basil-and-roasted-garlic/",
            "spoonacularSourceUrl": "https://spoonacular.com/pasta-with-fresh-tomatoes-basil-and-roasted-garlic-762330",
            "aggregateLikes": 102,
            "spoonacularScore": 61.0,
            "healthScore": 9.0,
            "creditsText": "Vegetarian Times",
            "sourceName": "Vegetarian Times",
            "pricePerServing": 134.2,
            "extendedIngredients": [{
              "id": 2069,
              "aisle": "Oil, Vinegar, Salad Dressing",
              "image": "balsamic-vinegar.jpg",
              "consitency": "liquid",
              "name": "balsamic vinegar",
              "original": "1 Tbs. balsamic vinegar",
              "originalString": "1 Tbs. balsamic vinegar",
              "originalName": "balsamic vinegar",
              "amount": 1.0,
              "unit": "Tbs",
              "meta": [],
              "metaInformation": [],
              "measures": {
                "us": {
                  "amount": 1.0,
                  "unitShort": "Tbs",
                  "unitLong": "Tb"
                },
                "metric": {
                  "amount": 1.0,
                  "unitShort": "Tbs",
                  "unitLong": "Tb"
                }
              }
            }, {
              "id": 99038,
              "aisle": "Pasta and Rice",
              "image": "brown-rice-vermicelli.png",
              "consitency": "solid",
              "name": "brown rice pasta",
              "original": "½ lb. rice pasta or whole-wheat pasta",
              "originalString": "½ lb. rice pasta or whole-wheat pasta",
              "originalName": "rice pasta or whole-wheat pasta",
              "amount": 0.5,
              "unit": "lb",
              "meta": ["whole-wheat"],
              "metaInformation": ["whole-wheat"],
              "measures": {
                "us": {
                  "amount": 0.5,
                  "unitShort": "lb",
                  "unitLong": "pounds"
                },
                "metric": {
                  "amount": 226.796,
                  "unitShort": "g",
                  "unitLong": "grams"
                }
              }
            }, {
              "id": 2054,
              "aisle": "Canned and Jarred",
              "image": "capers.jpg",
              "consitency": "solid",
              "name": "capers",
              "original": "1 Tbs. capers",
              "originalString": "1 Tbs. capers",
              "originalName": "capers",
              "amount": 1.0,
              "unit": "Tbs",
              "meta": [],
              "metaInformation": [],
              "measures": {
                "us": {
                  "amount": 1.0,
                  "unitShort": "Tbs",
                  "unitLong": "Tb"
                },
                "metric": {
                  "amount": 1.0,
                  "unitShort": "Tbs",
                  "unitLong": "Tb"
                }
              }
            }, {
              "id": 1034053,
              "aisle": "Oil, Vinegar, Salad Dressing",
              "image": "olive-oil.jpg",
              "consitency": "liquid",
              "name": "extra virgin olive oil",
              "original": "1 Tbs. extra virgin olive oil",
              "originalString": "1 Tbs. extra virgin olive oil",
              "originalName": "extra virgin olive oil",
              "amount": 1.0,
              "unit": "Tbs",
              "meta": [],
              "metaInformation": [],
              "measures": {
                "us": {
                  "amount": 1.0,
                  "unitShort": "Tbs",
                  "unitLong": "Tb"
                },
                "metric": {
                  "amount": 1.0,
                  "unitShort": "Tbs",
                  "unitLong": "Tb"
                }
              }
            }, {
              "id": 2044,
              "aisle": "Produce",
              "image": "fresh-basil.jpg",
              "consitency": "solid",
              "name": "fresh basil",
              "original": "1/3 cup chopped fresh basil",
              "originalString": "1/3 cup chopped fresh basil",
              "originalName": "chopped fresh basil",
              "amount": 0.3333333333333333,
              "unit": "cup",
              "meta": ["fresh", "chopped"],
              "metaInformation": ["fresh", "chopped"],
              "measures": {
                "us": {
                  "amount": 0.333,
                  "unitShort": "cups",
                  "unitLong": "cups"
                },
                "metric": {
                  "amount": 78.863,
                  "unitShort": "ml",
                  "unitLong": "milliliters"
                }
              }
            }, {
              "id": 11215,
              "aisle": "Produce",
              "image": "garlic.jpg",
              "consitency": "solid",
              "name": "garlic",
              "original": "10 cloves garlic",
              "originalString": "10 cloves garlic",
              "originalName": "garlic",
              "amount": 10.0,
              "unit": "cloves",
              "meta": [],
              "metaInformation": [],
              "measures": {
                "us": {
                  "amount": 10.0,
                  "unitShort": "cloves",
                  "unitLong": "cloves"
                },
                "metric": {
                  "amount": 10.0,
                  "unitShort": "cloves",
                  "unitLong": "cloves"
                }
              }
            }, {
              "id": 10411529,
              "aisle": "Produce",
              "image": "plum-tomatoes.png",
              "consitency": "solid",
              "name": "plum tomatoes",
              "original": "¾ lb. ripe plum tomatoes",
              "originalString": "¾ lb. ripe plum tomatoes",
              "originalName": "ripe plum tomatoes",
              "amount": 0.75,
              "unit": "lb",
              "meta": ["ripe"],
              "metaInformation": ["ripe"],
              "measures": {
                "us": {
                  "amount": 0.75,
                  "unitShort": "lb",
                  "unitLong": "pounds"
                },
                "metric": {
                  "amount": 340.194,
                  "unitShort": "g",
                  "unitLong": "grams"
                }
              }
            }],
            "id": 762330,
            "title": "Pasta with Fresh Tomatoes, Basil and Roasted Garlic",
            "readyInMinutes": 45,
            "servings": 4,
            "image": "https://spoonacular.com/recipeImages/762330-556x370.jpg",
            "imageType": "jpg",
            "cuisines": [],
            "dishTypes": ["side dish"],
            "diets": ["dairy free", "lacto ovo vegetarian", "vegan"],
            "occasions": [],
            "winePairing": {
              "pairedWines": [],
              "pairingText": "No one wine will suit every pasta dish. Pasta in a tomato-based sauce will usually work well with a medium-bodied red, such as a montepulciano or chianti. Pasta with seafood or pesto will fare better with a light-bodied white, such as a pinot grigio. Cheese-heavy pasta can pair well with red or white - you might try a sangiovese wine for hard cheeses and a chardonnay for soft cheeses. We may be able to make a better recommendation if you ask again with a specific pasta dish.",
              "productMatches": []
            },
            "instructions": "",
            "analyzedInstructions": []
          }, {
            "vegetarian": true,
            "vegan": true,
            "glutenFree": false,
            "dairyFree": true,
            "veryHealthy": false,
            "cheap": false,
            "veryPopular": false,
            "sustainable": false,
            "weightWatcherSmartPoints": 6,
            "gaps": "no",
            "lowFodmap": false,
            "ketogenic": false,
            "whole30": false,
            "sourceUrl": "http://www.vegetariantimes.com/recipe/apple-oat-bars/",
            "spoonacularSourceUrl": "https://spoonacular.com/apple-oat-bars-760634",
            "aggregateLikes": 96,
            "spoonacularScore": 29.0,
            "healthScore": 2.0,
            "creditsText": "Vegetarian Times",
            "sourceName": "Vegetarian Times",
            "pricePerServing": 26.24,
            "extendedIngredients": [{
              "id": 9016,
              "aisle": "Beverages",
              "image": "apple-juice.jpg",
              "consitency": "liquid",
              "name": "apple juice",
              "original": "1/3 cup apple cider or apple juice",
              "originalString": "1/3 cup apple cider or apple juice",
              "originalName": "apple cider or apple juice",
              "amount": 0.3333333333333333,
              "unit": "cup",
              "meta": [],
              "metaInformation": [],
              "measures": {
                "us": {
                  "amount": 0.333,
                  "unitShort": "cups",
                  "unitLong": "cups"
                },
                "metric": {
                  "amount": 78.863,
                  "unitShort": "ml",
                  "unitLong": "milliliters"
                }
              }
            }, {
              "id": 18371,
              "aisle": "Baking",
              "image": "white-powder.jpg",
              "consitency": "solid",
              "name": "baking powder",
              "original": "¾ tsp. baking powder",
              "originalString": "¾ tsp. baking powder",
              "originalName": "baking powder",
              "amount": 0.75,
              "unit": "tsp",
              "meta": [],
              "metaInformation": [],
              "measures": {
                "us": {
                  "amount": 0.75,
                  "unitShort": "tsps",
                  "unitLong": "teaspoons"
                },
                "metric": {
                  "amount": 0.75,
                  "unitShort": "tsps",
                  "unitLong": "teaspoons"
                }
              }
            }, {
              "id": 1012010,
              "aisle": "Spices and Seasonings",
              "image": "cinnamon.jpg",
              "consitency": "solid",
              "name": "ground cinnamon",
              "original": "½ tsp. ground cinnamon",
              "originalString": "½ tsp. ground cinnamon",
              "originalName": "ground cinnamon",
              "amount": 0.5,
              "unit": "tsp",
              "meta": [],
              "metaInformation": [],
              "measures": {
                "us": {
                  "amount": 0.5,
                  "unitShort": "tsps",
                  "unitLong": "teaspoons"
                },
                "metric": {
                  "amount": 0.5,
                  "unitShort": "tsps",
                  "unitLong": "teaspoons"
                }
              }
            }, {
              "id": 2025,
              "aisle": "Spices and Seasonings",
              "image": "ground-nutmeg.jpg",
              "consitency": "solid",
              "name": "ground nutmeg",
              "original": "¼ tsp. ground nutmeg",
              "originalString": "¼ tsp. ground nutmeg",
              "originalName": "ground nutmeg",
              "amount": 0.25,
              "unit": "tsp",
              "meta": [],
              "metaInformation": [],
              "measures": {
                "us": {
                  "amount": 0.25,
                  "unitShort": "tsps",
                  "unitLong": "teaspoons"
                },
                "metric": {
                  "amount": 0.25,
                  "unitShort": "tsps",
                  "unitLong": "teaspoons"
                }
              }
            }, {
              "id": 19334,
              "aisle": "Baking",
              "image": "light-brown-sugar.jpg",
              "consitency": "solid",
              "name": "light brown sugar",
              "original": "1 cup packed light brown sugar",
              "originalString": "1 cup packed light brown sugar",
              "originalName": "packed light brown sugar",
              "amount": 1.0,
              "unit": "cup",
              "meta": ["light", "packed"],
              "metaInformation": ["light", "packed"],
              "measures": {
                "us": {
                  "amount": 1.0,
                  "unitShort": "cup",
                  "unitLong": "cup"
                },
                "metric": {
                  "amount": 236.588,
                  "unitShort": "ml",
                  "unitLong": "milliliters"
                }
              }
            }, {
              "id": 8120,
              "aisle": "Cereal",
              "image": "rolled-oats.jpg",
              "consitency": "solid",
              "name": "old fashioned rolled oats",
              "original": "1 cup old-fashioned rolled oats",
              "originalString": "1 cup old-fashioned rolled oats",
              "originalName": "old-fashioned rolled oats",
              "amount": 1.0,
              "unit": "cup",
              "meta": [],
              "metaInformation": [],
              "measures": {
                "us": {
                  "amount": 1.0,
                  "unitShort": "cup",
                  "unitLong": "cup"
                },
                "metric": {
                  "amount": 236.588,
                  "unitShort": "ml",
                  "unitLong": "milliliters"
                }
              }
            }, {
              "id": 2047,
              "aisle": "Spices and Seasonings",
              "image": "salt.jpg",
              "consitency": "solid",
              "name": "salt",
              "original": "½ tsp. salt",
              "originalString": "½ tsp. salt",
              "originalName": "salt",
              "amount": 0.5,
              "unit": "tsp",
              "meta": [],
              "metaInformation": [],
              "measures": {
                "us": {
                  "amount": 0.5,
                  "unitShort": "tsps",
                  "unitLong": "teaspoons"
                },
                "metric": {
                  "amount": 0.5,
                  "unitShort": "tsps",
                  "unitLong": "teaspoons"
                }
              }
            }, {
              "id": 1029003,
              "aisle": "Produce",
              "image": "grannysmith-apple.png",
              "consitency": "solid",
              "name": "tart apples",
              "original": "3 cups peeled, chopped tart apples, such as Granny Smith",
              "originalString": "3 cups peeled, chopped tart apples, such as Granny Smith",
              "originalName": "peeled, chopped tart apples, such as Granny Smith",
              "amount": 3.0,
              "unit": "cups",
              "meta": [" such as granny smith", "peeled", "chopped"],
              "metaInformation": [" such as granny smith", "peeled", "chopped"],
              "measures": {
                "us": {
                  "amount": 3.0,
                  "unitShort": "cups",
                  "unitLong": "cups"
                },
                "metric": {
                  "amount": 709.764,
                  "unitShort": "ml",
                  "unitLong": "milliliters"
                }
              }
            }, {
              "id": 10020081,
              "aisle": "Baking",
              "image": "flour.png",
              "consitency": "solid",
              "name": "unbleached flour",
              "original": "1 ½ cups unbleached all-purpose flour",
              "originalString": "1 ½ cups unbleached all-purpose flour",
              "originalName": "unbleached all-purpose flour",
              "amount": 1.5,
              "unit": "cups",
              "meta": ["all-purpose"],
              "metaInformation": ["all-purpose"],
              "measures": {
                "us": {
                  "amount": 1.5,
                  "unitShort": "cups",
                  "unitLong": "cups"
                },
                "metric": {
                  "amount": 354.882,
                  "unitShort": "ml",
                  "unitLong": "milliliters"
                }
              }
            }, {
              "id": 4513,
              "aisle": "Oil, Vinegar, Salad Dressing",
              "image": "vegetable-oil.jpg",
              "consitency": "liquid",
              "name": "vegetable oil",
              "original": "3 Tbs. vegetable oil",
              "originalString": "3 Tbs. vegetable oil",
              "originalName": "vegetable oil",
              "amount": 3.0,
              "unit": "Tbs",
              "meta": [],
              "metaInformation": [],
              "measures": {
                "us": {
                  "amount": 3.0,
                  "unitShort": "Tbs",
                  "unitLong": "Tbs"
                },
                "metric": {
                  "amount": 3.0,
                  "unitShort": "Tbs",
                  "unitLong": "Tbs"
                }
              }
            }, {
              "id": 12155,
              "aisle": "Nuts;Savory Snacks;Baking",
              "image": "walnuts.jpg",
              "consitency": "solid",
              "name": "walnuts",
              "original": "¼ cup coarsely chopped walnuts, toasted, optional",
              "originalString": "¼ cup coarsely chopped walnuts, toasted, optional",
              "originalName": "coarsely chopped walnuts, toasted, optional",
              "amount": 0.25,
              "unit": "cup",
              "meta": ["toasted", "coarsely chopped"],
              "metaInformation": ["toasted", "coarsely chopped"],
              "measures": {
                "us": {
                  "amount": 0.25,
                  "unitShort": "cups",
                  "unitLong": "cups"
                },
                "metric": {
                  "amount": 59.147,
                  "unitShort": "ml",
                  "unitLong": "milliliters"
                }
              }
            }],
            "id": 760634,
            "title": "Apple-Oat Bars",
            "readyInMinutes": 45,
            "servings": 16,
            "image": "https://spoonacular.com/recipeImages/760634-556x370.jpg",
            "imageType": "jpg",
            "cuisines": [],
            "dishTypes": ["antipasti", "starter", "snack", "appetizer", "antipasto", "hor d'oeuvre"],
            "diets": ["dairy free", "lacto ovo vegetarian", "vegan"],
            "occasions": [],
            "winePairing": {},
            "instructions": "Preheat oven to 350F. Lightly grease 9-inch square baking pan, or coat with nonstick cooking spray.Mix flour, oats, brown sugar, baking powder, salt, cinnamon and nutmeg in mixing bowl. Using fork or fingertips, work in oil and cider until mixture resembles coarse crumbs.  Press about 1 1/2 cups oat mixture firmly into bottom of prepared pan. Sprinkle with apples. Mix walnuts into remaining oat mixture, sprinkle evenly over apples and pat into even layer.Bake 30 to 35 minutes, or until top is golden and apples are tender when pierced with a fork. Cool completely on a wire rack before cutting into bars. ",
            "analyzedInstructions": [{
              "name": "",
              "steps": [{
                "number": 1,
                "step": "Preheat oven to 350F. Lightly grease 9-inch square baking pan, or coat with nonstick cooking spray.",
                "ingredients": [],
                "equipment": [{
                  "id": 404646,
                  "name": "baking pan",
                  "image": "roasting-pan.jpg"
                }, {
                  "id": 404784,
                  "name": "oven",
                  "image": "oven.jpg",
                  "temperature": {
                    "number": 350.0,
                    "unit": "Fahrenheit"
                  }
                }]
              }, {
                "number": 2,
                "step": "Mix flour, oats, brown sugar, baking powder, salt, cinnamon and nutmeg in mixing bowl. Using fork or fingertips, work in oil and cider until mixture resembles coarse crumbs.  Press about 1 1/2 cups oat mixture firmly into bottom of prepared pan. Sprinkle with apples.",
                "ingredients": [{
                  "id": 18371,
                  "name": "baking powder",
                  "image": "white-powder.jpg"
                }, {
                  "id": 19334,
                  "name": "brown sugar",
                  "image": "dark-brown-sugar.png"
                }, {
                  "id": 2010,
                  "name": "cinnamon",
                  "image": "cinnamon.jpg"
                }, {
                  "id": 9003,
                  "name": "apple",
                  "image": "apple.jpg"
                }, {
                  "id": 2025,
                  "name": "nutmeg",
                  "image": "ground-nutmeg.jpg"
                }, {
                  "id": 8120,
                  "name": "oats",
                  "image": "rolled-oats.jpg"
                }, {
                  "id": 2047,
                  "name": "salt",
                  "image": "salt.jpg"
                }],
                "equipment": [{
                  "id": 405907,
                  "name": "mixing bowl",
                  "image": "mixing-bowl.jpg"
                }, {
                  "id": 404645,
                  "name": "frying pan",
                  "image": "pan.png"
                }]
              }, {
                "number": 3,
                "step": "Mix walnuts into remaining oat mixture, sprinkle evenly over apples and pat into even layer.",
                "ingredients": [{
                  "id": 12155,
                  "name": "walnuts",
                  "image": "walnuts.jpg"
                }, {
                  "id": 9003,
                  "name": "apple",
                  "image": "apple.jpg"
                }],
                "equipment": []
              }, {
                "number": 4,
                "step": "Bake 30 to 35 minutes, or until top is golden and apples are tender when pierced with a fork. Cool completely on a wire rack before cutting into bars. ",
                "ingredients": [{
                  "id": 9003,
                  "name": "apple",
                  "image": "apple.jpg"
                }],
                "equipment": [{
                  "id": 405900,
                  "name": "wire rack",
                  "image": "wire-rack.jpg"
                }],
                "length": {
                  "number": 30,
                  "unit": "minutes"
                }
              }]
            }]
          }, {
            "vegetarian": true,
            "vegan": true,
            "glutenFree": false,
            "dairyFree": true,
            "veryHealthy": false,
            "cheap": false,
            "veryPopular": false,
            "sustainable": false,
            "weightWatcherSmartPoints": 16,
            "gaps": "no",
            "lowFodmap": false,
            "ketogenic": false,
            "whole30": false,
            "preparationMinutes": 10,
            "cookingMinutes": 20,
            "sourceUrl": "http://www.godairyfree.org/recipes/dairy-free-desserts/coconut-pecan-fudge-frosting-vegan-gluten-free-soy-free",
            "spoonacularSourceUrl": "https://spoonacular.com/coconut-pecan-fudge-frosting-250693",
            "aggregateLikes": 9,
            "spoonacularScore": 23.0,
            "healthScore": 2.0,
            "creditsText": "Go Dairy Free",
            "sourceName": "Go Dairy Free",
            "pricePerServing": 72.49,
            "extendedIngredients": [{
              "id": 10014037,
              "aisle": "Alcoholic Beverages",
              "image": "bourbon.png",
              "consitency": "liquid",
              "name": "bourbon",
              "original": "1 Tbsp. bourbon, optional",
              "originalString": "1 Tbsp. bourbon, optional",
              "originalName": "bourbon, optional",
              "amount": 1.0,
              "unit": "Tbsp",
              "meta": [],
              "metaInformation": [],
              "measures": {
                "us": {
                  "amount": 1.0,
                  "unitShort": "Tbsp",
                  "unitLong": "Tbsp"
                },
                "metric": {
                  "amount": 1.0,
                  "unitShort": "Tbsp",
                  "unitLong": "Tbsp"
                }
              }
            }, {
              "id": 19334,
              "aisle": "Baking",
              "image": "light-brown-sugar.jpg",
              "consitency": "solid",
              "name": "brown sugar",
              "original": "1 cup brown sugar",
              "originalString": "1 cup brown sugar",
              "originalName": "brown sugar",
              "amount": 1.0,
              "unit": "cup",
              "meta": [],
              "metaInformation": [],
              "measures": {
                "us": {
                  "amount": 1.0,
                  "unitShort": "cup",
                  "unitLong": "cup"
                },
                "metric": {
                  "amount": 236.588,
                  "unitShort": "ml",
                  "unitLong": "milliliters"
                }
              }
            }, {
              "id": 12118,
              "aisle": "Canned and Jarred;Milk, Eggs, Other Dairy",
              "image": "coconut-milk.png",
              "consitency": "liquid",
              "name": "coconut milk",
              "original": "3/4 cup coconut milk",
              "originalString": "3/4 cup coconut milk",
              "originalName": "coconut milk",
              "amount": 0.75,
              "unit": "cup",
              "meta": [],
              "metaInformation": [],
              "measures": {
                "us": {
                  "amount": 0.75,
                  "unitShort": "cups",
                  "unitLong": "cups"
                },
                "metric": {
                  "amount": 177.441,
                  "unitShort": "ml",
                  "unitLong": "milliliters"
                }
              }
            }, {
              "id": 20027,
              "aisle": "Baking",
              "image": "white-powder.jpg",
              "consitency": "solid",
              "name": "cornstarch",
              "original": "2 Tbsp. cornstarch",
              "originalString": "2 Tbsp. cornstarch",
              "originalName": "cornstarch",
              "amount": 2.0,
              "unit": "Tbsp",
              "meta": [],
              "metaInformation": [],
              "measures": {
                "us": {
                  "amount": 2.0,
                  "unitShort": "Tbsps",
                  "unitLong": "Tbsps"
                },
                "metric": {
                  "amount": 2.0,
                  "unitShort": "Tbsps",
                  "unitLong": "Tbsps"
                }
              }
            }, {
              "id": 12142,
              "aisle": "Nuts;Baking",
              "image": "pecans.jpg",
              "consitency": "solid",
              "name": "pecans",
              "original": "1/2 cup pecans, coarsely chopped",
              "originalString": "1/2 cup pecans, coarsely chopped",
              "originalName": "pecans, coarsely chopped",
              "amount": 0.5,
              "unit": "cup",
              "meta": ["coarsely chopped"],
              "metaInformation": ["coarsely chopped"],
              "measures": {
                "us": {
                  "amount": 0.5,
                  "unitShort": "cups",
                  "unitLong": "cups"
                },
                "metric": {
                  "amount": 118.294,
                  "unitShort": "ml",
                  "unitLong": "milliliters"
                }
              }
            }, {
              "id": 93761,
              "aisle": "Milk, Eggs, Other Dairy",
              "image": "rice-milk.png",
              "consitency": "liquid",
              "name": "rice milk",
              "original": "1/4 cup rice milk",
              "originalString": "1/4 cup rice milk",
              "originalName": "rice milk",
              "amount": 0.25,
              "unit": "cup",
              "meta": [],
              "metaInformation": [],
              "measures": {
                "us": {
                  "amount": 0.25,
                  "unitShort": "cups",
                  "unitLong": "cups"
                },
                "metric": {
                  "amount": 59.147,
                  "unitShort": "ml",
                  "unitLong": "milliliters"
                }
              }
            }, {
              "id": 2047,
              "aisle": "Spices and Seasonings",
              "image": "salt.jpg",
              "consitency": "solid",
              "name": "salt",
              "original": "pinch of salt",
              "originalString": "pinch of salt",
              "originalName": "pinch of salt",
              "amount": 1.0,
              "unit": "pinch",
              "meta": [],
              "metaInformation": [],
              "measures": {
                "us": {
                  "amount": 1.0,
                  "unitShort": "pinch",
                  "unitLong": "pinch"
                },
                "metric": {
                  "amount": 1.0,
                  "unitShort": "pinch",
                  "unitLong": "pinch"
                }
              }
            }, {
              "id": 10012108,
              "aisle": "Baking",
              "image": "shredded-coconut.jpg",
              "consitency": "solid",
              "name": "unsweetened shredded coconut",
              "original": "1 1/2 cups shredded unsweetened coconut",
              "originalString": "1 1/2 cups shredded unsweetened coconut",
              "originalName": "shredded unsweetened coconut",
              "amount": 1.5,
              "unit": "cups",
              "meta": ["shredded", "unsweetened"],
              "metaInformation": ["shredded", "unsweetened"],
              "measures": {
                "us": {
                  "amount": 1.5,
                  "unitShort": "cups",
                  "unitLong": "cups"
                },
                "metric": {
                  "amount": 354.882,
                  "unitShort": "ml",
                  "unitLong": "milliliters"
                }
              }
            }, {
              "id": 2050,
              "aisle": "Baking",
              "image": "vanilla-extract.jpg",
              "consitency": "solid",
              "name": "vanilla extract",
              "original": "1 tsp. vanilla extract",
              "originalString": "1 tsp. vanilla extract",
              "originalName": "vanilla extract",
              "amount": 1.0,
              "unit": "tsp",
              "meta": [],
              "metaInformation": [],
              "measures": {
                "us": {
                  "amount": 1.0,
                  "unitShort": "tsp",
                  "unitLong": "teaspoon"
                },
                "metric": {
                  "amount": 1.0,
                  "unitShort": "tsp",
                  "unitLong": "teaspoon"
                }
              }
            }],
            "id": 250693,
            "title": "Coconut Pecan Fudge Frosting",
            "readyInMinutes": 30,
            "servings": 8,
            "image": "https://spoonacular.com/recipeImages/250693-556x370.jpg",
            "imageType": "jpg",
            "cuisines": [],
            "dishTypes": ["frosting", "icing"],
            "diets": ["dairy free", "lacto ovo vegetarian", "vegan"],
            "occasions": [],
            "winePairing": {},
            "instructions": "Whisk rice milk, cornstarch and salt in a small bowl.In a large, stainless-steel saucepan over medium heat, stir together the coconut milk and brown sugar.Cook, stirring occasionally, until mixture starts to boil. Turn down heat to low and cook, stirring occasionally, for 5 minutes.Whisk the rice-milk mixture once more, and slowly pour into the coconut-milk mixture, stirring constantly to incorporate.Stir mixture continuously, until it darkens, gets very thick and smooth, and cornstarch is cooked, about 6 to 7 minutes.Remove from heat and beat in vanilla and bourbon, chopped pecans and coconut.Stir until everything is coated and completely combined.Cool to room temperature before frosting cupcakes.",
            "analyzedInstructions": [{
              "name": "",
              "steps": [{
                "number": 1,
                "step": "Whisk rice milk, cornstarch and salt in a small bowl.In a large, stainless-steel saucepan over medium heat, stir together the coconut milk and brown sugar.Cook, stirring occasionally, until mixture starts to boil. Turn down heat to low and cook, stirring occasionally, for 5 minutes.",
                "ingredients": [{
                  "id": 12118,
                  "name": "coconut milk",
                  "image": "coconut-milk.png"
                }, {
                  "id": 19334,
                  "name": "brown sugar",
                  "image": "dark-brown-sugar.png"
                }, {
                  "id": 20027,
                  "name": "corn starch",
                  "image": "white-powder.jpg"
                }, {
                  "id": 93761,
                  "name": "rice milk",
                  "image": "rice-milk.png"
                }, {
                  "id": 2047,
                  "name": "salt",
                  "image": "salt.jpg"
                }],
                "equipment": [{
                  "id": 404669,
                  "name": "sauce pan",
                  "image": "sauce-pan.jpg"
                }, {
                  "id": 404661,
                  "name": "whisk",
                  "image": "whisk.png"
                }, {
                  "id": 404783,
                  "name": "bowl",
                  "image": "bowl.jpg"
                }],
                "length": {
                  "number": 5,
                  "unit": "minutes"
                }
              }, {
                "number": 2,
                "step": "Whisk the rice-milk mixture once more, and slowly pour into the coconut-milk mixture, stirring constantly to incorporate.Stir mixture continuously, until it darkens, gets very thick and smooth, and cornstarch is cooked, about 6 to 7 minutes.",
                "ingredients": [{
                  "id": 20027,
                  "name": "corn starch",
                  "image": "white-powder.jpg"
                }],
                "equipment": [{
                  "id": 404661,
                  "name": "whisk",
                  "image": "whisk.png"
                }],
                "length": {
                  "number": 6,
                  "unit": "minutes"
                }
              }, {
                "number": 3,
                "step": "Remove from heat and beat in vanilla and bourbon, chopped pecans and coconut.Stir until everything is coated and completely combined.Cool to room temperature before frosting cupcakes.",
                "ingredients": [{
                  "id": 10012142,
                  "name": "pecan pieces",
                  "image": "pecans.jpg"
                }, {
                  "id": 10014037,
                  "name": "bourbon",
                  "image": "bourbon.png"
                }, {
                  "id": 2050,
                  "name": "vanilla",
                  "image": "vanilla.jpg"
                }],
                "equipment": []
              }]
            }]
          }, {
            "vegetarian": true,
            "vegan": true,
            "glutenFree": true,
            "dairyFree": true,
            "veryHealthy": false,
            "cheap": false,
            "veryPopular": false,
            "sustainable": false,
            "weightWatcherSmartPoints": 1,
            "gaps": "no",
            "lowFodmap": false,
            "ketogenic": false,
            "whole30": true,
            "sourceUrl": "http://allrecipes.com/Recipe/Rainbow-Roasted-Pepper-Soup/",
            "spoonacularSourceUrl": "https://spoonacular.com/rainbow-roasted-pepper-soup-459325",
            "aggregateLikes": 63,
            "spoonacularScore": 91.0,
            "healthScore": 31.0,
            "creditsText": "Allrecipes",
            "sourceName": "Allrecipes",
            "pricePerServing": 325.33,
            "extendedIngredients": [{
              "id": 2042,
              "aisle": "Spices and Seasonings",
              "image": "thyme.jpg",
              "consitency": "solid",
              "name": "dried thyme",
              "original": "1/4 teaspoon dried thyme",
              "originalString": "1/4 teaspoon dried thyme",
              "originalName": "dried thyme",
              "amount": 0.25,
              "unit": "teaspoon",
              "meta": ["dried"],
              "metaInformation": ["dried"],
              "measures": {
                "us": {
                  "amount": 0.25,
                  "unitShort": "tsps",
                  "unitLong": "teaspoons"
                },
                "metric": {
                  "amount": 0.25,
                  "unitShort": "tsps",
                  "unitLong": "teaspoons"
                }
              }
            }, {
              "id": 2018,
              "aisle": "Spices and Seasonings",
              "image": "fennel-seeds.jpg",
              "consitency": "solid",
              "name": "fennel seed",
              "original": "1 teaspoon fennel seed",
              "originalString": "1 teaspoon fennel seed",
              "originalName": "fennel seed",
              "amount": 1.0,
              "unit": "teaspoon",
              "meta": [],
              "metaInformation": [],
              "measures": {
                "us": {
                  "amount": 1.0,
                  "unitShort": "tsp",
                  "unitLong": "teaspoon"
                },
                "metric": {
                  "amount": 1.0,
                  "unitShort": "tsp",
                  "unitLong": "teaspoon"
                }
              }
            }, {
              "id": 11215,
              "aisle": "Produce",
              "image": "garlic.jpg",
              "consitency": "solid",
              "name": "garlic",
              "original": "8 cloves garlic",
              "originalString": "8 cloves garlic",
              "originalName": "garlic",
              "amount": 8.0,
              "unit": "cloves",
              "meta": [],
              "metaInformation": [],
              "measures": {
                "us": {
                  "amount": 8.0,
                  "unitShort": "cloves",
                  "unitLong": "cloves"
                },
                "metric": {
                  "amount": 8.0,
                  "unitShort": "cloves",
                  "unitLong": "cloves"
                }
              }
            }, {
              "id": 1062047,
              "aisle": "Spices and Seasonings",
              "image": "garlic-salt.jpg",
              "consitency": "solid",
              "name": "garlic salt",
              "original": "1/4 teaspoon garlic salt",
              "originalString": "1/4 teaspoon garlic salt",
              "originalName": "garlic salt",
              "amount": 0.25,
              "unit": "teaspoon",
              "meta": [],
              "metaInformation": [],
              "measures": {
                "us": {
                  "amount": 0.25,
                  "unitShort": "tsps",
                  "unitLong": "teaspoons"
                },
                "metric": {
                  "amount": 0.25,
                  "unitShort": "tsps",
                  "unitLong": "teaspoons"
                }
              }
            }, {
              "id": 11333,
              "aisle": "Produce",
              "image": "green-pepper.jpg",
              "consitency": "solid",
              "name": "green bell pepper",
              "original": "1 green bell pepper",
              "originalString": "1 green bell pepper",
              "originalName": "green bell pepper",
              "amount": 1.0,
              "unit": "",
              "meta": ["green"],
              "metaInformation": ["green"],
              "measures": {
                "us": {
                  "amount": 1.0,
                  "unitShort": "",
                  "unitLong": ""
                },
                "metric": {
                  "amount": 1.0,
                  "unitShort": "",
                  "unitLong": ""
                }
              }
            }, {
              "id": 1002030,
              "aisle": "Spices and Seasonings",
              "image": "pepper.jpg",
              "consitency": "solid",
              "name": "ground pepper",
              "original": "ground black pepper to taste",
              "originalString": "ground black pepper to taste",
              "originalName": "ground black pepper to taste",
              "amount": 2.0,
              "unit": "servings",
              "meta": ["black", "to taste"],
              "metaInformation": ["black", "to taste"],
              "measures": {
                "us": {
                  "amount": 2.0,
                  "unitShort": "servings",
                  "unitLong": "servings"
                },
                "metric": {
                  "amount": 2.0,
                  "unitShort": "servings",
                  "unitLong": "servings"
                }
              }
            }, {
              "id": 9150,
              "aisle": "Produce",
              "image": "lemon.png",
              "consitency": "solid",
              "name": "lemon",
              "original": "1/2 lemon",
              "originalString": "1/2 lemon",
              "originalName": "lemon",
              "amount": 0.5,
              "unit": "",
              "meta": [],
              "metaInformation": [],
              "measures": {
                "us": {
                  "amount": 0.5,
                  "unitShort": "",
                  "unitLong": ""
                },
                "metric": {
                  "amount": 0.5,
                  "unitShort": "",
                  "unitLong": ""
                }
              }
            }, {
              "id": 10011821,
              "aisle": "Produce",
              "image": "bell-pepper-orange.png",
              "consitency": "solid",
              "name": "orange bell pepper",
              "original": "1 large orange bell pepper",
              "originalString": "1 large orange bell pepper",
              "originalName": "orange bell pepper",
              "amount": 1.0,
              "unit": "large",
              "meta": [],
              "metaInformation": [],
              "measures": {
                "us": {
                  "amount": 1.0,
                  "unitShort": "large",
                  "unitLong": "large"
                },
                "metric": {
                  "amount": 1.0,
                  "unitShort": "large",
                  "unitLong": "large"
                }
              }
            }, {
              "id": 11821,
              "aisle": "Produce",
              "image": "red-pepper.jpg",
              "consitency": "solid",
              "name": "red bell pepper",
              "original": "1 large red bell pepper",
              "originalString": "1 large red bell pepper",
              "originalName": "red bell pepper",
              "amount": 1.0,
              "unit": "large",
              "meta": ["red"],
              "metaInformation": ["red"],
              "measures": {
                "us": {
                  "amount": 1.0,
                  "unitShort": "large",
                  "unitLong": "large"
                },
                "metric": {
                  "amount": 1.0,
                  "unitShort": "large",
                  "unitLong": "large"
                }
              }
            }, {
              "id": 6615,
              "aisle": "Canned and Jarred",
              "image": "chicken-broth.png",
              "consitency": "liquid",
              "name": "vegetable broth",
              "original": "3 cups vegetable broth",
              "originalString": "3 cups vegetable broth",
              "originalName": "vegetable broth",
              "amount": 3.0,
              "unit": "cups",
              "meta": [],
              "metaInformation": [],
              "measures": {
                "us": {
                  "amount": 3.0,
                  "unitShort": "cups",
                  "unitLong": "cups"
                },
                "metric": {
                  "amount": 709.764,
                  "unitShort": "ml",
                  "unitLong": "milliliters"
                }
              }
            }, {
              "id": 11951,
              "aisle": "Produce",
              "image": "yellow-bell-pepper.jpg",
              "consitency": "solid",
              "name": "yellow bell pepper",
              "original": "1 yellow bell pepper",
              "originalString": "1 yellow bell pepper",
              "originalName": "yellow bell pepper",
              "amount": 1.0,
              "unit": "",
              "meta": ["yellow"],
              "metaInformation": ["yellow"],
              "measures": {
                "us": {
                  "amount": 1.0,
                  "unitShort": "",
                  "unitLong": ""
                },
                "metric": {
                  "amount": 1.0,
                  "unitShort": "",
                  "unitLong": ""
                }
              }
            }],
            "id": 459325,
            "title": "Rainbow Roasted Pepper Soup",
            "readyInMinutes": 45,
            "servings": 2,
            "image": "https://spoonacular.com/recipeImages/459325-556x370.jpg",
            "imageType": "jpg",
            "cuisines": [],
            "dishTypes": ["soup"],
            "diets": ["gluten free", "dairy free", "paleolithic", "lacto ovo vegetarian", "primal", "whole 30", "vegan"],
            "occasions": ["fall", "winter"],
            "winePairing": {},
            "instructions": "Preheat oven to 375 degrees F (190 degrees C) , halve all peppers (remove seeds)  and peel garlic.                            Place halved peppers, cut side up in shallow baking dish.  Place one garlic clove in each half and squeeze lemon juice generously over peppers. Roast for 1 hour.                            Meanwhile pour vegetable broth into a 2 quart sauce pan and add fennel seeds.  Bring to boil, cover and simmer.                            When peppers are done, remove from oven and set aside to cool.  When cool enough to touch peel skin from peppers.                            Strain fennel seeds from broth and return to a boil.  Add thyme and simmer 15 minutes, reducing amount of broth.                            Slice a 1 inch section from each color of pepper and cut into pieces.  Set aside for later garnishing.                            In a blender, place remaining peppers, garlic  and a 1/2 cup broth on blend just long enough to shred the peppers, but not puree them.  You want to see the different colors.  Pour the blended peppers into the broth and stir well.  Add garlic salt and black pepper to taste, then add garnishing pepper pieces and enjoy.  Do not boil or cook any longer as the colors will fade.                                                Kitchen-Friendly View",
            "analyzedInstructions": [{
              "name": "",
              "steps": [{
                "number": 1,
                "step": "Preheat oven to 375 degrees F (190 degrees C) , halve all peppers (remove seeds)  and peel garlic.",
                "ingredients": [{
                  "id": 10111333,
                  "name": "peppers",
                  "image": "green-pepper.jpg"
                }, {
                  "id": 11215,
                  "name": "garlic",
                  "image": "garlic.png"
                }],
                "equipment": [{
                  "id": 404784,
                  "name": "oven",
                  "image": "oven.jpg",
                  "temperature": {
                    "number": 375.0,
                    "unit": "Fahrenheit"
                  }
                }]
              }, {
                "number": 2,
                "step": "Place halved peppers, cut side up in shallow baking dish.",
                "ingredients": [{
                  "id": 10111333,
                  "name": "peppers",
                  "image": "green-pepper.jpg"
                }],
                "equipment": [{
                  "id": 404646,
                  "name": "baking pan",
                  "image": "roasting-pan.jpg"
                }]
              }, {
                "number": 3,
                "step": "Place one garlic clove in each half and squeeze lemon juice generously over peppers. Roast for 1 hour.",
                "ingredients": [{
                  "id": 11215,
                  "name": "whole garlic cloves",
                  "image": "garlic.jpg"
                }, {
                  "id": 10111333,
                  "name": "peppers",
                  "image": "green-pepper.jpg"
                }],
                "equipment": []
              }, {
                "number": 4,
                "step": "Meanwhile pour vegetable broth into a 2 quart sauce pan and add fennel seeds.  Bring to boil, cover and simmer.",
                "ingredients": [{
                  "id": 6615,
                  "name": "vegetable broth",
                  "image": "chicken-broth.png"
                }, {
                  "id": 2018,
                  "name": "fennel seeds",
                  "image": "fennel-seeds.jpg"
                }],
                "equipment": [{
                  "id": 404669,
                  "name": "sauce pan",
                  "image": "sauce-pan.jpg"
                }]
              }, {
                "number": 5,
                "step": "When peppers are done, remove from oven and set aside to cool.  When cool enough to touch peel skin from peppers.",
                "ingredients": [{
                  "id": 10111333,
                  "name": "peppers",
                  "image": "green-pepper.jpg"
                }],
                "equipment": [{
                  "id": 404784,
                  "name": "oven",
                  "image": "oven.jpg"
                }]
              }, {
                "number": 6,
                "step": "Strain fennel seeds from broth and return to a boil.",
                "ingredients": [{
                  "id": 2018,
                  "name": "fennel seeds",
                  "image": "fennel-seeds.jpg"
                }, {
                  "id": 1006615,
                  "name": "broth",
                  "image": "chicken-broth.png"
                }],
                "equipment": []
              }, {
                "number": 7,
                "step": "Add thyme and simmer 15 minutes, reducing amount of broth.",
                "ingredients": [{
                  "id": 1006615,
                  "name": "broth",
                  "image": "chicken-broth.png"
                }],
                "equipment": [],
                "length": {
                  "number": 15,
                  "unit": "minutes"
                }
              }, {
                "number": 8,
                "step": "Slice a 1 inch section from each color of pepper and cut into pieces.  Set aside for later garnishing.",
                "ingredients": [{
                  "id": 1002030,
                  "name": "pepper",
                  "image": "pepper.jpg"
                }],
                "equipment": []
              }, {
                "number": 9,
                "step": "In a blender, place remaining peppers, garlic  and a 1/2 cup broth on blend just long enough to shred the peppers, but not puree them.  You want to see the different colors.",
                "ingredients": [{
                  "id": 10111333,
                  "name": "peppers",
                  "image": "green-pepper.jpg"
                }, {
                  "id": 11215,
                  "name": "garlic",
                  "image": "garlic.png"
                }, {
                  "id": 1006615,
                  "name": "broth",
                  "image": "chicken-broth.png"
                }],
                "equipment": [{
                  "id": 404726,
                  "name": "blender",
                  "image": "blender.png"
                }]
              }, {
                "number": 10,
                "step": "Pour the blended peppers into the broth and stir well.",
                "ingredients": [{
                  "id": 10111333,
                  "name": "peppers",
                  "image": "green-pepper.jpg"
                }, {
                  "id": 1006615,
                  "name": "broth",
                  "image": "chicken-broth.png"
                }],
                "equipment": []
              }, {
                "number": 11,
                "step": "Add garlic salt and black pepper to taste, then add garnishing pepper pieces and enjoy.  Do not boil or cook any longer as the colors will fade.",
                "ingredients": [{
                  "id": 1102047,
                  "name": "salt and pepper",
                  "image": "salt-and-pepper.jpg"
                }, {
                  "id": 11215,
                  "name": "garlic",
                  "image": "garlic.png"
                }, {
                  "id": 1002030,
                  "name": "pepper",
                  "image": "pepper.jpg"
                }],
                "equipment": []
              }]
            }]
          }]
        }
"""
    
}
