//
//  Guestlist.swift
//  Picky
//
//  Created by Alex Mills on 1/11/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//

import Foundation

class Guestlist: NSObject {
    
    // public variables, rather than getters
    var id:Int = 0
    var name:String = "Default"
    var members:[Guest]
//    var diets:[Diet]
//    var allergies:[Allergy]
    
    init(name:String, members:[Guest]) {
        self.id += 1
        self.name = name
        self.members = members
        // self.diets = combineDiets()
        // self.allergies = combineAllergies()
    }
    
    // Returns the length of the guest list
    var count:Int {
        return members.endIndex + 1
    }
    
    // Combines each distinct allergy from underlying set of guests
    var allergies:[Enums.Allergy] {
        var combo:[Enums.Allergy] = []
        for member in members {
            let memberAllergies = member.allergies
            for memberAllergy in memberAllergies {
                combo.append(memberAllergy)
            }
        }
        
        // TODO: Remove duplicates from array
        
        return combo
    }
    
    // Combines each distinct diet from underlying set of guests
    var diets:[Enums.Diet] {
        var combo:[Enums.Diet] = []
        for member in members {
            let memberDiets = member.diets
            for memberDiet in memberDiets {
                combo.append(memberDiet)
            }
        }
        
        // TODO: Remove duplicates from array
        
        return combo
    }
    
    // Returns all guest summaries to console
    var summary:String {
        var result:[String] = []
        for member in members {
            result.append(member.summary)
        }
        return result.joined(separator: "\n\n")
    }
    
    func add(guest:Guest) {
        members.append(guest)
    }
}
