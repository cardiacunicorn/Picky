//
//  GuestsViewModel.swift
//  Picky
//
//  Created by Alex Mills on 20/10/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//

import UIKit

struct GuestsViewModel {
    
    private var guestsManager = GuestsManager.shared
    var guests:[Guest] = []
    var activeGuestlist:Guestlist = GuestsManager.shared.getGuestlists()[0]
    
    init() {
        loadData()
        // Needs to do this only if they aren't already stored in Core Data
        loadPlaceholders()
        print("Active Guestlist: \(String(describing: activeGuestlist.name))")
        print("Active Guestlist's Filters: \(activeGuestlist.allergies), \(activeGuestlist.diets)")
    }
    
    // returns the number of guests on active guestlist
    var count:Int {
        return activeGuestlist.guests?.count ?? 0
    }
    
    // convenience method for comparison to filtered guest count
    var totalGuests:Int {
        return guestsManager.getGuests().count
    }
    
    // loads a bunch of placeholder guests
    private mutating func loadPlaceholders() {
        // Placeholder Guest Objects
        if (guests.count == 0) {
            guestsManager.addGuest("Edit with pencil",[],[],["Default"])
            guestsManager.addGuest("Remove from current guestlist with minus sign",[],[],["Default"])
            guestsManager.addGuest("or Delete entirely by swiping left",[],[],["Default"])
            guestsManager.addGuest("Alexander G. Bell", [Enums.Allergy.Dairy], [],["Default","Friends","Family"])
            guestsManager.addGuest("Colin Decemberist", [Enums.Allergy.Shellfish],[Enums.Diet.Pescatarian],["Default","Colleagues","Family"])
            guestsManager.addGuest("Edie Falco", [Enums.Allergy.Wheat,Enums.Allergy.Peanut,Enums.Allergy.Dairy], [Enums.Diet.Vegetarian],["Default","Friends"])
            guestsManager.addGuest("Gwendolyn Humphries", [Enums.Allergy.Gluten,Enums.Allergy.Seafood], [Enums.Diet.Vegetarian],["Default","Friends","Colleagues"])
            guestsManager.addGuest("Iggy Joplin", [], [Enums.Diet.Vegan],["Default","Colleagues"])
        }
    }
    
    mutating func loadData() {
        activeGuestlist = guestsManager.getGuestlists()[guestsManager.activeGuestlistIndex]
        guests = guestsManager.getGuests()
    }
    
    // Adds a guest to the list of guests
    mutating func addGuest(_ name:String, _ allergies:[Enums.Allergy], _ diets:[Enums.Diet], _ guestlists:[String]) {
        guestsManager.addGuest(name, allergies, diets, guestlists)
        print("New guest created:\(name)")
        loadData()
    }
    
    func getGuest(byIndex index:Int) -> (name:String, allergies:[Enums.Allergy], diets:[Enums.Diet], guestlists:[String]) {
        
        
        let activeGuests:[Guest] = activeGuestlist.guests?.allObjects as! [Guest]
        
        guard
            let guestName = activeGuests[index].name,
            let guestAllergyStrings = activeGuests[index].allergies,
            let guestDietStrings = activeGuests[index].diets,
            let guestGuestlists  = activeGuests[index].guestlists
        else { return ("Data read error",[],[],["Guest not in guestlist"]) }
        
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
        let guestlists:[Guestlist] = guestGuestlists.allObjects as! [Guestlist]
        var guestlistStrings:[String] = []
        for guestlist in guestlists {
            guestlistStrings.append(guestlist.name ?? "Data Error")
        }
        return (guestName, guestAllergies, guestDiets, guestlistStrings)
    }
    
    // Removes guest from active guestlist, according to the name passed in
    mutating func removeGuest(_ name:String) {
        for guest in guests {
            if (guest.name == name) {
                guest.removeFromGuestlists(activeGuestlist)
                print("\(name) has been removed from \(String(describing: activeGuestlist.name))")
            }
        }
        loadData()
    }
    
    // Should delete a guest (very different to above method)
    mutating func deleteGuest(byIndex index:Int) {
        guestsManager.deleteGuest(byIndex: index)
        print("Guest has been deleted")
        loadData()
    }
    
    mutating func editGuest()  {
        // TODO
        print("Editing guest")
    }
}
