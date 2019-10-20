//
//  GuestsViewModel.swift
//  Picky
//
//  Created by Alex Mills on 20/10/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//

import UIKit

struct GuestsViewModel {
    
    private var guests:[Guest] = []
    
    init() {
        loadData()
    }
    
    // returns the number of guests
    var count:Int {
        return guests.count
    }
    
    // loads a bunch of placeholder guests
    private mutating func loadData() {
        guests.append(guest1)
        guests.append(guest2)
        guests.append(guest3)
        guests.append(guest4)
    }
    
    func getGuest(byIndex index:Int) -> (id:Int, name:String, groups:[String], diets:[Diet], allergies:[Allergy]) {
        let id = guests[index].id
        let name = guests[index].name
        let groups = guests[index].groups
        let diets = guests[index].diets
        let allergies = guests[index].allergies
        
        return (id, name, groups, diets, allergies)
    }
    
    // Adds a guest to the list of guests
    mutating func addGuest(newGuest:Guest) {
        guests.append(newGuest)
        print("Complete list of guests:\n\(guests)")
    }
    
    // Removes item from the shopping list, according to the IndexPath passed in
    mutating func removeGuest(byIndex indexPath:IndexPath) {
        guests.remove(at: indexPath.row)
        print("Guest has been removed")
    }
    
    // Placeholder Guest Objects
    private var guest1 = Guest(id: 1, name: "Alexander G. Bell", groups: ["Family","Friends"], diets: [Diet.OvoVegetarian,Diet.Halal], allergies: [Allergy.Lactose])
    private var guest2 = Guest(id: 2, name: "Colin Decemberist", groups: ["Friends","Colleagues"], diets: [Diet.Vegetarian], allergies: [Allergy.Gluten])
    private var guest3 = Guest(id: 3, name: "Edie Falco", groups: ["Friends"], diets: [Diet.Pescatarian], allergies: [Allergy.Shellfish,Allergy.Treenut])
    private var guest4 = Guest(id: 4, name: "Gwendolyn Humphries", groups: ["Family"], diets: [Diet.Kosher], allergies: [Allergy.Wheat,Allergy.Peanut])
}
