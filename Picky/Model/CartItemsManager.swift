//
//  ShoppingListManager.swift
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
    func createNSShoppingItem(_ name: String) {
        let itemEntity = NSEntityDescription.entity(forEntityName:"ShoppingListItemEntity", in:managedContext)!
        
        // let nsShoppingItem
    }
}
