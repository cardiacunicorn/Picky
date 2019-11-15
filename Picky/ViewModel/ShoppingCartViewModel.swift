//
//  ShoppingViewModel.swift
//  Picky
//
//  Created by Alex Mills on 18/10/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//

import UIKit

struct ShoppingCartViewModel {
    
    private var shoppingCart:[String] = []
    private var cartItems:[CartItem] = []
    private var cartItemsManager = CartItemsManager.shared
    
    init() {
        loadData()
        cartItems = cartItemsManager.getCartItems()
    }
    
    // Returns the number of shopping cart items
    var count:Int {
        return cartItems.count
    }
    
    func getShoppingCartViewModel() -> ShoppingCartViewModel {
        return self
    }
    
    // Loads the placeholder shopping items for demo display
    private mutating func loadData() {
        // Needs to do this only if they aren't already stored in Core Data
        cartItemsManager.addCartItem(item1)
        cartItemsManager.addCartItem(item2)
        cartItemsManager.addCartItem(item3)
        cartItemsManager.addCartItem(item4)
        cartItemsManager.addCartItem(item5)
        cartItemsManager.addCartItem(item6)
    }
    
    // Retrieves an item by its index
    func getItem(byIndex index:Int) -> (name:String, recipe:String) {
        guard let itemName = cartItems[index].name else { return ("Data error","Error") }
        return (itemName, "Default")
    }
    
    // Adds a new item to the shopping cart
    mutating func addItem(newItem:String) {
        shoppingCart.append(newItem)
    }
    
    // Removes item from the shopping cart, according to the IndexPath passed in
    mutating func removeItem(byIndex index:Int) {
        print("\(shoppingCart[index]) has been removed")
        shoppingCart.remove(at: index)
    }
    
    // Adds a new item to the shopping cart
    mutating func addCartItem(_ name:String, _ recipe:String = "None") {
        print("Added '\(name)' to the shopping cart")
        cartItemsManager.addCartItem(name, recipe)
        print("Shopping cart: \(shoppingCart.count) items")
    }
    
    mutating func markItem() {
        // TODO
    }
    
    // Placeholder Shopping Items
    var item1 = "Sugar"
    var item2 = "Spice"
    var item3 = "All things nice"
    var item4 = "Tap to mark off an item"
    var item5 = "Swipe left to delete an item"
    var item6 = "Tap the pen icon to edit an item"
}
