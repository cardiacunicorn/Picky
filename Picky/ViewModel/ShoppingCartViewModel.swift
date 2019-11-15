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
    
    // Creating this ViewModel as a singleton - don't want multiple shopping carts
    private init() {
        // loadData() // Turned off to test persistence
    }
    static var shared = ShoppingCartViewModel()
    
    // Returns the number of shopping cart items
    var count:Int {
        print(cartItems)
        return cartItems.count
    }
    
    func getShoppingCartViewModel() -> ShoppingCartViewModel {
        return self
    }
    
    // Loads the placeholder shopping items for demo display
    private mutating func loadData() {
//        shoppingCart.append(item1)
//        shoppingCart.append(item2)
//        shoppingCart.append(item3)
//        shoppingCart.append(item4)
//        shoppingCart.append(item5)
//        shoppingCart.append(item6)
        cartItemsManager.addCartItem(item1)
    }
    
    // Retrieves an item by its index
    func getItem(byIndex index:Int) -> (name:String, recipe:String) {
        // let content = shoppingCart[index]
        // return content
        
        print(index)
        print(cartItems)
        
        // this is throwing an error because I have corrupted/missing array items in core data
        // guard let itemName = cartItems[index].name else { return ("Data error","Error") }
        let itemName = cartItems[index].name ?? "No such item" // Wait, why is it throwing here when I'm adding an item?
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
