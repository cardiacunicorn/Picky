//
//  Guest.swift
//  Picky
//
//  Created by Alex Mills on 09/10/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//

import Foundation

class Guest: NSObject {
    
    // public variables, rather than getters
    var id:Int = 0
    var name:String
    var groups:[String]
    var diets:[Enums.Diet]
    var allergies:[Enums.Allergy]
    
    init(name:String, groups:[String] = [], diets:[Enums.Diet] = [], allergies:[Enums.Allergy] = []) {
        self.id += 1
        self.name = name
        self.groups = groups
        self.diets = diets
        self.allergies = allergies
    }
    
    // Returns Guest details to console
    var summary:String {
        return "Guest: \(name)\nGuest ID: \(id)\nGroups: \(groups)\nDiet(s): \(diets)\nAllergies: \(allergies)";
    }
    
}
