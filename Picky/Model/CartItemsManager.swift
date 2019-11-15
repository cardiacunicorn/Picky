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
    
    private init() {
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    // Not returning anything (yet)
    func createNSCartItem(_ name:String, _ recipe:String = "None") -> CartItemEntity {
        let cartItemEntity = NSEntityDescription.entity(forEntityName:"CartItemEntity", in:managedContext)!
        let nsShoppingItem = NSManagedObject(entity: cartItemEntity, insertInto: managedContext) as! CartItemEntity
        
        // Set values for the created object
        nsShoppingItem.setValue(UUID().uuidString, forKeyPath: "id")
        nsShoppingItem.setValue(name, forKeyPath: "name")
        nsShoppingItem.setValue(recipe, forKeyPath: "recipe")
        return nsShoppingItem
    }
}
