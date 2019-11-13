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
    private var guestlist:Guestlist = Guestlist(name:"Testlist",members:[])
    
    init() {
        loadData()
    }
    
    // returns the number of guests
    var count:Int {
        return guests.count
    }
    
    // loads a bunch of placeholder guests
    private mutating func loadData() {
        guests.append(guest6)
        guests.append(guest7)
        guests.append(guest8)
        guests.append(guest1)
        guests.append(guest2)
        guests.append(guest3)
        guests.append(guest4)
        guests.append(guest5)
        
        guestlist.add(guest: guest3)
        guestlist.add(guest: guest2)
        guestlist.add(guest: guest5)
        print("Selected guestlist allergies: \(guestlist.allergies)")
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
        print("New guest created:\(newGuest.name), with ID '\(newGuest.id)'")
    }
    
    // Removes item from the shopping list, according to the IndexPath passed in
    mutating func removeGuest(byIndex index:Int) {
        guests.remove(at: index)
        print("Guest has been removed")
    }
    
    // Placeholder Guest Objects
    private var guest1 = Guest(name: "Alexander G. Bell", groups: ["All","Family","Friends"], diets: [Diet.OvoVegetarian], allergies: [Allergy.Dairy])
    private var guest2 = Guest(name: "Colin Decemberist", groups: ["All","Friends","Colleagues"], diets: [Diet.Vegetarian], allergies: [Allergy.Gluten,Allergy.TreeNut])
    private var guest3 = Guest(name: "Edie Falco", groups: ["All","Friends"], diets: [Diet.Pescatarian], allergies: [Allergy.Shellfish,Allergy.TreeNut])
    private var guest4 = Guest(name: "Gwendolyn Humphries", groups: ["All","Family"], diets: [], allergies: [Allergy.Wheat,Allergy.Peanut])
    private var guest5 = Guest(name: "Iggy Joplin", groups: ["All"], diets: [], allergies: [])
    private var guest6 = Guest(name: "Edit with pencil", groups: [], diets: [], allergies: [])
    private var guest7 = Guest(name: "Remove from current guestlist with minus sign", groups: [], diets: [], allergies: [])
    private var guest8 = Guest(name: "or Delete entirely by swiping left", groups: [], diets: [], allergies: [])
}
