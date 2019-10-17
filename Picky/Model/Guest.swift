//
//  Guest.swift
//  Picky
//
//  Created by Alex Mills on 09/10/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//

import Foundation

enum Allergy: String {
    case Gluten, Shellfish, Nut, Treenut, Peanut, Soy
}

struct Guest {
    
    private var id:Int
    private var name:String
    private var groups:[String]
    private var diets:[Diet]
    private var allergies:[Allergy]
    
    // hardcoded ID number
    init(id:Int = 1, name:String, groups:[String] = [], diets:[Diet] = [], allergies:[Allergy] = []) {
        self.id = id
        self.name = name
        self.groups = groups
        self.diets = diets
        self.allergies = allergies
        
        print(guestx.summary)
        print(veganGuest.summary)
        print(glutenGuest.summary)
        
    }
    
    // Returns Guest details to console
    var summary:String {
        let result = "Guest: \(name)\nGuest ID: \(id)\nGroups: \(groups)\nDiet(s): \(diets)\nAllergies: \(allergies)"
        return result;
    }
    
}

// Some placeholder guests data
var guestx = Guest(name: "GuestX", groups: ["Family","Friends"], diets: [Diet.Pescatarian], allergies: [Allergy.Gluten,Allergy.Shellfish])

var veganGuest = Guest(id: 2, name: "GuestV", diets: [Diet.Vegan])

var glutenGuest = Guest(id: 3, name: "GuestG", groups: ["Friends"], allergies: [Allergy.Gluten])
