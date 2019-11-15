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
        loadItems()
    }
    
    // Creates the object
    private func createNSCartItem(_ name:String, _ recipe:String) -> CartItem {
        let cartItemEntity = NSEntityDescription.entity(forEntityName:"CartItemEntity", in:managedContext)!
        let nsCartItem = NSManagedObject(entity: cartItemEntity, insertInto: managedContext) as! CartItem
        
        // Set values for the created object
        nsCartItem.setValue(UUID().uuidString, forKeyPath: "id")
        nsCartItem.setValue(name, forKeyPath: "name")
        nsCartItem.setValue(recipe, forKeyPath: "recipe")
        return nsCartItem
    }
    
    
    func addCartItem(_ name:String, _ recipe:String) {
        let nsCartItem = createNSCartItem(name, recipe)
        cartItems.append(nsCartItem)
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save: \(error), \(error.userInfo)")
        }
    }
    
    func loadItems() {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CartItem")
            cartItems = try managedContext.fetch(fetchRequest) as! [CartItem]
        } catch let error as NSError {
            print("Could not save: \(error), \(error.userInfo)")
        }
    }
}
