//
//  GuestsViewModel.swift
//  Picky
//
//  Created by Alex Mills on 21/10/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//

import UIKit

struct GuestlistsViewModel {
    
    private var guestsManager = GuestsManager.shared
    private var guestlists:[Guestlist] = []
    private var activeGuestlist:Guestlist = GuestsManager.shared.getGuestlists()[0]
    
    init() {
        // guestsManager.deleteAllGuestlists() // for testing purposes only
        loadData()
        // Needs to do this only if they aren't already stored in Core Data
        loadPlaceholder()
        print("Active Guestlist: \(String(describing: activeGuestlist.name))")
    }
    
    // returns the number of guestlists
    var count:Int {
        return guestlists.count
    }
    
    // loads a default guestlist
    private mutating func loadPlaceholder() {
        // Safeguard if there's no guest list
        if (guestlists.count == 0) {
            guestsManager.addGuestlist("Default")
            activeGuestlist = guestsManager.getGuestlists()[guestsManager.activeGuestlistIndex]
        }
    }
    
    mutating func loadData() {
        guestlists = guestsManager.getGuestlists()
        // Handles a crash error if you delete the active guestlist
        if (guestsManager.activeGuestlistIndex > guestlists.count) {
            guestsManager.activeGuestlistIndex = 0
            if (guestlists.count == 0) {
                guestsManager.addGuestlist("Default")
            }
        }
        activeGuestlist = guestlists[guestsManager.activeGuestlistIndex]
    }
    
    // Adds a guest to the list of guests
    mutating func addGuestlist(_ name:String) {
        guestsManager.addGuestlist(name)
        print("New guest created:\(name)")
        loadData()
    }
    
    func getGuestlist(byIndex index:Int) -> (name:String, allergies:[Enums.Allergy], diets:[Enums.Diet]) {
        
        guard
            let guestlistName = guestlists[index].name,
            let guestlistAllergyStrings = guestlists[index].allergies,
            let guestlistDietStrings = guestlists[index].diets
        else { return ("Guestlist read error",[],[]) }
        
        var guestlistAllergies:[Enums.Allergy] = []
        for string in guestlistAllergyStrings {
            let allergy = Enums.Allergy(rawValue: string)
            guestlistAllergies.append(allergy!)
        }
        var guestlistDiets:[Enums.Diet] = []
        for string in guestlistDietStrings {
            let diet = Enums.Diet(rawValue: string)
            guestlistDiets.append(diet!)
        }
        return (guestlistName, guestlistAllergies, guestlistDiets)
    }
    
    mutating func setGuestlist(_ name:String) {
        for (index, guestlist) in guestlists.enumerated() {
            if (guestlist.name == name) {
                guestsManager.activeGuestlistIndex = index
                activeGuestlist = guestsManager.getGuestlists()[index]
                print("Active guestlist index changed to \(guestsManager.activeGuestlistIndex)")
            }
        }
    }
    
    // Should delete a guestlist
    mutating func deleteGuestlist(byIndex index:Int) {
        guestlists.remove(at: index)
        guestsManager.deleteGuestlist(byIndex: index)
        print("Guestlist has been deleted")
    }
    
    mutating func editGuestlist()  {
        // TODO
        print("Editing guestlist")
    }
}
