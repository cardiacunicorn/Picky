//
//  CartItemManager.swift
//  Picky
//
//  Created by Alex Mills on 15/11/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CartItemsManager {
    // Created as a singleton, don't want multiple copies floating around
    static let shared = CartItemsManager()
    
    let appDelegate =  UIApplication.shared.delegate as! AppDelegate
    let managedContext: NSManagedObjectContext
    
    private var cartItems:[CartItem]  = []
    
    private init() {
        managedContext = appDelegate.persistentContainer.viewContext
        deleteAllItems()
        loadItems()
    }
    
    func getCartItems() -> [CartItem] {
        loadItems()
        return cartItems
    }
    
    // CRUD Request: Create item in Managed Context
    private func createNSCartItem(_ name:String, _ recipe:String) -> CartItem {
        let cartItemEntity = NSEntityDescription.entity(forEntityName:"CartItem", in:managedContext)!
        let nsCartItem = NSManagedObject(entity: cartItemEntity, insertInto: managedContext) as! CartItem
        
        // Set values for the created object
        nsCartItem.setValue(name, forKeyPath: "name")
        nsCartItem.setValue(recipe, forKeyPath: "recipe")
        return nsCartItem
    }
    
    // CRUD Request: Run above to Create a CartItem; Add it to memory; Save ManagedContext to CoreData
    func addCartItem(_ name:String, _ recipe:String = "None") {
        let nsCartItem = createNSCartItem(name, recipe)
        cartItems.append(nsCartItem)
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save: \(error), \(error.userInfo)")
        }
    }
    
    // CRUD Request: Read from CoreData
    private func loadItems() {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CartItem")
            cartItems = try managedContext.fetch(fetchRequest) as! [CartItem]
        } catch let error as NSError {
            print("Could not save: \(error), \(error.userInfo)")
        }
    }
    
    // CRUD Request: Delete object from CoreData
    private func deleteItem(byIndex index:Int) {
        // let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CartItem")
        do {
            managedContext.delete(cartItems[index])
            try managedContext.save()
        } catch {
            print("Error in deleting")
            return
        }
    }
    
    func removeItem(byIndex index:Int) {
        deleteItem(byIndex: index)
    }
    
    // CRUD Request: Convenience method for deleting all saved Core Data objects
    private func deleteAllItems() {
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CartItem")
        // Configure Fetch Request to save on loading up each of the objects
        fetchRequest.includesPropertyValues = false
        do {
            let items = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            for item in items {
                managedContext.delete(item)
            }
            try managedContext.save()
        } catch {
            print("Error in deleting")
            return
        }
    }
}
