//
//  ShoppingViewModel.swift
//  Picky
//
//  Created by Alex Mills on 18/10/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//

import UIKit

struct ShoppingCartViewModel {
    
    private var cartItems:[CartItem] = []
    private var cartItemsManager = CartItemsManager.shared
    
    init() {
        loadCartItems()
        // Needs to do this only if they aren't already stored in Core Data
        loadPlaceholders()
    }
    
    // Returns the number of shopping cart items
    var count:Int {
        return cartItems.count
    }
    
    // Loads the placeholder shopping items for demo display
    private mutating func loadPlaceholders() {
        // Not a perfect solution, but easier than mucking around with state across App sessions
        if (cartItems.count == 0) {
            cartItemsManager.addCartItem("Sugar")
            cartItemsManager.addCartItem("Spice")
            cartItemsManager.addCartItem("All things nice")
            cartItemsManager.addCartItem("Tap the checkbox to mark off an item")
            cartItemsManager.addCartItem("Swipe left to delete an item")
            cartItemsManager.addCartItem("Tap the pen icon to edit an item")
        }
    }
    
    mutating func loadCartItems() {
        cartItems = cartItemsManager.getCartItems()
    }
    
    // Retrieves an item by its index
    func getItem(byIndex index:Int) -> (name:String, recipe:String, checked:Bool) {
        guard let itemName = cartItems[index].name else { return ("Data error","Error",false) }
        return (itemName, cartItems[index].recipe ?? "Ungrouped", cartItems[index].crossedOut)
    }
    
    // Removes item from the shopping cart, according to the IndexPath passed in
    mutating func removeItem(byIndex index:Int) {
        cartItemsManager.removeItem(byIndex: index)
        print("Item has been removed")
        loadCartItems()
    }
    
    // Adds a new item to the shopping cart
    mutating func addItem(_ name:String, _ recipe:String = "None") {
        print("Added '\(name)' to the shopping cart")
        cartItemsManager.addCartItem(name, recipe)
        loadCartItems()
    }
    
    mutating func toggleChecked(_ item:String) {
        cartItemsManager.toggleChecked(item)
        loadCartItems()
    }
}
