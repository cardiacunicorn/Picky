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
    
    private var guestsManager = GuestsManager.shared
    private var guestEntities:[GuestEntity] = []
    private var guestlists:[GuestlistEntity] = []
    private var activeGuestlist:GuestlistEntity = GuestsManager.shared.getGuestlists()[0]
    
    init() {
        // deleteAllGuestData() // shouldn't be required
        loadData()
        // Needs to do this only if they aren't already stored in Core Data
        loadPlaceholders()
        print("Active Guestlist: \(String(describing: activeGuestlist.name))")
        print("Active Guestlist Tags: \n\n\(activeGuestlist.allergies)\n\n\(activeGuestlist.diets)")
    }
    
    // returns the number of guests
    var count:Int {
        return guestEntities.count
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
    }
    
    mutating func loadData() {
        guestEntities = guestsManager.getGuests()
        guestlists = guestsManager.getGuestlists()
        print("*** updated counts ***\n guests [GuestsViewModel]: \(guestEntities.count)\n  guestlists [GuestsViewModel]: \(guestlists.count)")
    }
    
    // Adds a guest to the list of guests
    mutating func addGuest(newGuest:Guest) {
        guests.append(newGuest)
        print("New guest created:\(newGuest.name)")
    }
    
    func getGuest(byIndex index:Int) -> (name:String, allergies:[Enums.Allergy], diets:[Enums.Diet], guestlists:[String]) {
        
        guard
            let guestName = guestEntities[index].name,
            let guestAllergyStrings = guestEntities[index].allergies,
            let guestDietStrings = guestEntities[index].diets,
            let guestGuestlists  = guestEntities[index].guestlists
        else { return ("Data read error",[],[],["Guest does not exist"]) }
        
        var guestAllergies:[Enums.Allergy] = []
        for string in guestAllergyStrings {
            let allergy = Enums.Allergy(rawValue: string)
            guestAllergies.append(allergy!)
        }
        var guestDiets:[Enums.Diet] = []
        for string in guestDietStrings {
            let diet = Enums.Diet(rawValue: string)
            guestDiets.append(diet!)
        }
        // let guestlists:[String] = guestGuestlists.allObjects as? [String] ?? []
        let guestlists:[GuestlistEntity] = guestGuestlists.allObjects as! [GuestlistEntity]
        var guestlistStrings:[String] = []
        for guestlist in guestlists {
            guestlistStrings.append(guestlist.name ?? "Data Error")
        }
        
        return (guestName, guestAllergies, guestDiets, guestlistStrings)
    }
    
    // Removes guest from active guestlist, according to the IndexPath passed in
    mutating func removeGuest(byIndex index:Int) {
        guests.remove(at: index)
        guestsManager.removeGuest(byIndex: index)
        print("Guest has been removed")
    }
    
    mutating func removeGuest(byCell cell:UITableViewCell) {
//        guests.remove(at: index)
//        guestsManager.removeGuest(byIndex: index)
        print("Guest has been removed")
    }
    
    // Should delete a guest (very different to above method)
    mutating func deleteGuest(byIndex index:Int) {
        guests.remove(at: index)
        guestsManager.deleteGuest(byIndex: index)
        print("Guest has been deleted")
    }
    
    mutating func deleteAllGuestData() {
        guestsManager.deleteAllGuests()
        guestsManager.deleteAllGuestlists()
    }
    
    mutating func editGuest()  {
        // TODO
        print("Editing guest")
    }
}
