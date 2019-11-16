//
//  Enums.swift
//  Picky
//
//  Created by Alex Mills on 16/11/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//

import Foundation
import CoreData

class Enums : NSManagedObject {
    
    enum Allergy:String {
        case
            Dairy,
            Egg,
            Gluten,
            Grain,
            Peanut,
            Seafood,
            Sesame,
            Shellfish,
            Soy,
            Sulfite,
            TreeNut = "Tree Nuts",
            Wheat
    }
    
    enum Diet:String {
        case
            GlutenFree = "Gluten Free",
            Ketogenic,
            Vegetarian,
            LactoVegetarian = "Lacto-Vegetarian",
            OvoVegetarian = "Ovo-Vegetarian",
            Vegan,
            Pescatarian,
            Paleo,
            Primal,
            Whole30
    }
    
    enum Cuisine:String {
        case
            African = "African",
            American = "American",
            British = "British",
            Cajun = "Cajun",
            Caribbean = "Caribbean",
            Chinese = "Chinese",
            EasternEuropean = "Eastern European",
            European = "European",
            French = "French",
            German = "German",
            Greek = "Greek",
            Indian = "Indian",
            Irish = "Irish",
            Italian = "Italian",
            Japanese = "Japanese",
            Jewish = "Jewish",
            Korean = "Korean",
            LatinAmerican = "Latin American",
            Mediterranean = "Mediterranean",
            Mexican = "Mexican",
            MiddleEastern = "Middle Eastern",
            Nordic = "Nordic",
            Southern = "Southern",
            Spanish = "Spanish",
            Thai = "Thai",
            Vietnamese = "Vietnamese"
    }
}
