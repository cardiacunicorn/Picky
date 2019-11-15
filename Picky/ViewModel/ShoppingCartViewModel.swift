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
    
    // Creating this ViewModel as a singleton - don't want multiple shopping lists
    private init() {
        loadData()
    }
    static var shared = ShoppingCartViewModel()
    
    // Returns the number of shopping list items
    var count:Int {
        return shoppingCart.count
    }
    
    func getShoppingCartViewModel() -> ShoppingCartViewModel {
        return self
    }
    
    // Loads the placeholder shopping items for demo display
    private mutating func loadData() {
        shoppingCart.append(item1)
        shoppingCart.append(item2)
        shoppingCart.append(item3)
        shoppingCart.append(item4)
        shoppingCart.append(item5)
        shoppingCart.append(item6)
    }
    
    // Retrieves an item by its index
    func getItem(byIndex index:Int) -> (String) {
        let content = shoppingCart[index]
        return content
    }
    
    // Adds a new item to the shopping list
    mutating func addItem(newItem:String) {
        shoppingCart.append(newItem)
        print("Added '\(newItem)' to the shopping list")
        print("Shopping list: \(shoppingCart.count) items")
    }
    
    // Removes item from the shopping list, according to the IndexPath passed in
    mutating func removeItem(byIndex index:Int) {
        print("\(shoppingCart[index]) has been removed")
        shoppingCart.remove(at: index)
    }
    
    mutating func addCartItem(_ name:String, _ recipe:String = "None") {
        cartItemsManager.addCartItem(name, recipe)
    }
    
    // Placeholder Shopping Items
    var item1 = "Sugar"
    var item2 = "Spice"
    var item3 = "All things nice"
    var item4 = "Tap to mark off an item"
    var item5 = "Swipe left to delete an item"
    var item6 = "Tap the pen icon to edit an item"
}
