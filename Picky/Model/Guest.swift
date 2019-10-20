//
//  Guest.swift
//  Picky
//
//  Created by Alex Mills on 09/10/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//

struct Guest {
    
    var id:Int
    var name:String
    var groups:[String]
    var diets:[Diet]
    var allergies:[Allergy]
    
    init(id:Int, name:String, groups:[String] = [], diets:[Diet] = [], allergies:[Allergy] = []) {
        self.id = id
        self.name = name
        self.groups = groups
        self.diets = diets
        self.allergies = allergies
    }
    
    // Returns Guest details to console
    var summary:String {
        let result = "Guest: \(name)\nGuest ID: \(id)\nGroups: \(groups)\nDiet(s): \(diets)\nAllergies: \(allergies)"
        return result;
    }
    
}
