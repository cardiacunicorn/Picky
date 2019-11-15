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
    
    private var guests:[GuestEntity]  = []
    
    private init() {
        managedContext = appDelegate.persistentContainer.viewContext
        loadItems()
    }
    
    // Creates the object
    private func createNSGuest(_ name:String, _ allergies:String, _ diets:String) -> GuestEntity {
        let guestEntity = NSEntityDescription.entity(forEntityName:"GuestEntity", in:managedContext)!
        let nsGuest = NSManagedObject(entity: guestEntity, insertInto: managedContext) as! GuestEntity
        
        // Set values for the created object
        nsGuest.setValue(name, forKeyPath: "name")
        nsGuest.setValue(allergies, forKeyPath: "allergies")
        nsGuest.setValue(diets, forKeyPath: "diets")
        return nsGuest
    }
    
    
    func addGuest(_ name:String, _ allergies:String, _ diets:String) {
        let nsGuest = createNSGuest(name, allergies, diets)
        guests.append(nsGuest)
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save: \(error), \(error.userInfo)")
        }
    }
    
    func loadItems() {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GuestEntity")
            guests = try managedContext.fetch(fetchRequest) as! [GuestEntity]
        } catch let error as NSError {
            print("Could not save: \(error), \(error.userInfo)")
        }
    }
}
