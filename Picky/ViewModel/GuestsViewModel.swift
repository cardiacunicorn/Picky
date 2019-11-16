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
    private var guestlist:Guestlist = Guestlist(name:"Default",members:[])
    
    private var guestsManager = GuestsManager.shared
    private var guestEntities:[GuestEntity] = []
    private var guestlists:[GuestlistEntity] = []
    // private var activeGuestlist:GuestlistEntity
    
    init() {
        deleteAllGuestData() // shouldn't be required
        loadData()
        // Needs to do this only if they aren't already stored in Core Data
        loadPlaceholders()
    }
    
    // returns the number of guests
    var count:Int {
        return guests.count
    }
    
    // loads a bunch of placeholder guests
    private mutating func loadPlaceholders() {
        if (guestlists.count == 0) {
            guestsManager.addGuestlist("Default")
            // activeGuestlist = getGuestlist("Default")
        }
        // Placeholder Guest Objects
        if (guestEntities.count == 0) {
            guestsManager.addGuest("Edit with pencil")
            guestsManager.addGuest("Remove from current guestlist with minus sign")
            guestsManager.addGuest("or Delete entirely by swiping left")
            guestsManager.addGuest("Alexander G. Bell", [Enums.Allergy.Dairy], [Enums.Diet.Vegetarian])
            guestsManager.addGuest("Colin Decemberist", [Enums.Allergy.Shellfish,Enums.Allergy.TreeNut], [Enums.Diet.Pescatarian])
            guestsManager.addGuest("Edie Falco", [Enums.Allergy.Wheat,Enums.Allergy.Peanut,Enums.Allergy.Dairy], [Enums.Diet.OvoVegetarian])
            guestsManager.addGuest("Gwendolyn Humphries", [Enums.Allergy.Gluten,Enums.Allergy.TreeNut], [Enums.Diet.Vegetarian])
            guestsManager.addGuest("Iggy Joplin", [], [Enums.Diet.Vegan])
        }
        print("Selected guestlist allergies: \(guestlist.allergies)")
    }
    
    mutating func loadData() {
        guestEntities = guestsManager.getGuests()
        guestlists = guestsManager.getGuestlists()
        print("*** updated counts ***\n guests [GuestsViewModel]: \(guestEntities.count)\n  guestlists [GuestsViewModel]: \(guestlists.count)")
    }
    
    func getGuest(byIndex index:Int) -> (name:String, groups:[String], diets:[Enums.Diet], allergies:[Enums.Allergy]) {
        let name = guests[index].name
        let groups = guests[index].groups
        let diets = guests[index].diets
        let allergies = guests[index].allergies
        
        return (name, groups, diets, allergies)
    }
    
    // Adds a guest to the list of guests
    mutating func addGuest(newGuest:Guest) {
        guests.append(newGuest)
        print("New guest created:\(newGuest.name)")
    }
    
    // Removes item from the shopping list, according to the IndexPath passed in
    mutating func removeGuest(byIndex index:Int) {
        guests.remove(at: index)
        print("Guest has been removed")
    }
    
    mutating func deleteAllGuestData() {
        guestsManager.deleteAllGuests()
        guestsManager.deleteAllGuestlists()
    }
}
