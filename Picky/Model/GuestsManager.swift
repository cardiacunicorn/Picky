//
//  GuestsManager.swift
//  Picky
//
//  Created by Alex Mills on 15/11/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class GuestsManager {
    // Created as a singleton, don't want multiple copies floating around
    // Unless of course I go the route of a guestmanager per guestlist
    static let shared = GuestsManager()
    
    let appDelegate =  UIApplication.shared.delegate as! AppDelegate
    let managedContext: NSManagedObjectContext
    
    // 'global' refers to all stored data, ViewModel is responsible for filtering subsets of this
    private var globalGuests:[GuestEntity]  = []
    private var globalGuestlists:[GuestlistEntity] = []
    
    private init() {
        managedContext = appDelegate.persistentContainer.viewContext
        loadGuests()
        loadGuestlists()
    }
    
    
    // Crud Request: Create guest in Managed Context
    private func createNSGuest(_ name:String, _ allergies:[Enums.Allergy], _ diets:[Enums.Diet], _ guestlists:[GuestlistEntity] = []) -> GuestEntity {
        let guestEntity = NSEntityDescription.entity(forEntityName:"GuestEntity", in:managedContext)!
        let nsGuest = NSManagedObject(entity: guestEntity, insertInto: managedContext) as! GuestEntity
        
        // Because of difficulties saving Enums as Transformable, they are converted to Strings for CoreData simplification
        var stringAllergies:[String]  = []
        for allergy in allergies {
            stringAllergies.append(allergy.rawValue)
        }
        var stringDiets:[String] = []
        for diet in diets {
            stringDiets.append(diet.rawValue)
        }
        
        // Set values for the created object
        nsGuest.setValue(name, forKeyPath: "name")
        nsGuest.setValue(stringAllergies, forKeyPath: "allergies")
        nsGuest.setValue(stringDiets, forKeyPath: "diets")
        // Will add guest to guestlists if Guestlist objects are provided
        for guestlist in guestlists {
            nsGuest.addToGuestlists(guestlist)
        }
        return nsGuest
    }
    
    // Crud Request: Create guestlist in Managed Context
    private func createNSGuestlist(_ name:String, _ allergies:[Enums.Allergy], _ diets:[Enums.Diet]) -> GuestlistEntity {
        let guestlistEntity = NSEntityDescription.entity(forEntityName:"GuestlistEntity", in:managedContext)!
        let nsGuestlist = NSManagedObject(entity: guestlistEntity, insertInto: managedContext) as! GuestlistEntity
        
        // Because of difficulties saving Enums as Transformable, they are converted to Strings for CoreData simplification
        var stringAllergies:[String]  = []
        for allergy in allergies {
            stringAllergies.append(allergy.rawValue)
        }
        var stringDiets:[String] = []
        for diet in diets {
            stringDiets.append(diet.rawValue)
        }
        
        // Set values for the created object
        nsGuestlist.setValue(name, forKeyPath: "name")
        nsGuestlist.setValue(allergies, forKeyPath: "allergies")
        nsGuestlist.setValue(diets, forKeyPath: "diets")
        return nsGuestlist
    }
    
    // Crud Request: Run above to Create a Guest; Add it to memory; Save ManagedContext to CoreData
    func addGuest(_ name:String, _ allergies:[Enums.Allergy] = [], _ diets:[Enums.Diet] = [], _ paramGuestlists:[String] = ["Default"]) {
        
        // Represents GuestListEntity versions of paramGuestlists
        var intendedGuestlists:[GuestlistEntity] = []
        
        // For each intended guestlist, check if it exists, otherwise create it
        for paramGuestlist in paramGuestlists {
            var exists = false
            for guestlist in globalGuestlists {
                if (guestlist.name == paramGuestlist) {
                    exists = true
                    intendedGuestlists.append(guestlist)
                } else { print("No match") }
            }
            if (!exists) {
                // Create the Guestlist, as it does not exist
                let intendedGuestlist = createNSGuestlist(paramGuestlist,[],[])
                // Add it to the full list of guestlists
                globalGuestlists.append(intendedGuestlist)
                // And add it to the list of Guestlists yet to be attached to a new Guest
                intendedGuestlists.append(intendedGuestlist)
            }
        }
        
        // Now that each intended guestlist definitely exists, create the guest
        // Guest creation will take care of attaching the Guest to Guestlists
        let nsGuest = createNSGuest(name, allergies, diets, intendedGuestlists)
        
        globalGuests.append(nsGuest)
        
        do {
            try managedContext.save()
            print("New guest created: \(nsGuest.name)")
        } catch let error as NSError {
            print("Could not save: \(error), \(error.userInfo)")
        }
    }
    
    // Crud Request: Run above to Create a Guestlist; Add it to memory; Save ManagedContext to CoreData
    func addGuestlist(_ name:String, _ allergies:[Enums.Allergy] = [], _ diets:[Enums.Diet] = []) {
        let nsGuestlist = createNSGuestlist(name, allergies, diets)
        globalGuestlists.append(nsGuestlist)
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save: \(error), \(error.userInfo)")
        }
    }
    
    // cRud Request: Retrieve Guests from CoreData
    private func loadGuests() {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GuestEntity")
            globalGuests = try managedContext.fetch(fetchRequest) as! [GuestEntity]
        } catch let error as NSError {
            print("Could not save: \(error), \(error.userInfo)")
        }
    }
    
    // cRud Request: Retrieve Guestlists from CoreData
    private func loadGuestlists() {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GuestlistEntity")
            globalGuestlists = try managedContext.fetch(fetchRequest) as! [GuestlistEntity]
        } catch let error as NSError {
            print("Could not save: \(error), \(error.userInfo)")
        }
    }
    
    // cRud Request: Read from CoreData
    func getGuests() -> [GuestEntity] {
        loadGuests()
        return globalGuests
    }
    
    // cRud Request: Read from CoreData
    func getGuestlists() -> [GuestlistEntity] {
        loadGuestlists()
        return globalGuestlists
    }
    
    func removeGuest(byIndex index:Int) {
        // TODO
        print("Removing guest")
    }
    
    // cruD Request: Delete a Guest object from CoreData
    func deleteGuest(byIndex index:Int) {
        do {
            managedContext.delete(globalGuests[index])
            try managedContext.save()
        } catch {
            print("Error in deleting guest")
            return
        }
    }
    
    // cruD Request: Delete Guestlist object from CoreData
    func deleteGuestlist(byIndex index:Int) {
        do {
            managedContext.delete(globalGuestlists[index])
            try managedContext.save()
        } catch {
            print("Error in deleting guestlist")
            return
        }
    }
    
    // cruD Request: Convenience method for deleting all saved Core Data Guests
    func deleteAllGuests() {
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GuestEntity")
        // Configure Fetch Request to save on loading up each of the objects
        fetchRequest.includesPropertyValues = false
        do {
            let guests = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            for guest in guests {
                managedContext.delete(guest)
            }
            try managedContext.save()
        } catch {
            print("Error in deleting all guests")
            return
        }
    }
    
    // cruD Request: Convenience method for deleting all saved Core Data Guestlists
    func deleteAllGuestlists() {
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GuestlistEntity")
        // Configure Fetch Request to save on loading up each of the objects
        fetchRequest.includesPropertyValues = false
        do {
            let guestlists = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            for guestlist in guestlists {
                managedContext.delete(guestlist)
            }
            try managedContext.save()
        } catch {
            print("Error in deleting all guestlist objects")
            return
        }
    }
}
