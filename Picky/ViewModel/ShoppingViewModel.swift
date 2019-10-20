//
//  ShoppingViewModel.swift
//  Picky
//
//  Created by Alex Mills on 18/10/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//

import UIKit

struct ShoppingViewModel {
    
    private (set) var shoppingList:[String] = []
    
    // TODO: Convert String array to a key value Dictionary, to allow grouping by Recipe
    
    init() {
        loadData()
    }
    
    var count:Int {
        return shoppingList.count
    }
    
    private mutating func loadData() {
        shoppingList.append(item1)
        shoppingList.append(item2)
        shoppingList.append(item3)
        shoppingList.append(item4)
        shoppingList.append(item5)
        shoppingList.append(item6)
        shoppingList.append(item7)
        shoppingList.append(item8)
    }
    
    func getItem(byIndex index:Int) -> (String) {
        let content = shoppingList[index]
        return content
    }
    
    // Placeholder Shopping Items
    var item1 = "Sugar"
    var item2 = "Salt"
    var item3 = "Spices: Nutmeg, Tumeric, Cumin"
    var item4 = "Chocolate (cooking & dark)"
    var item5 = "2 bottles of red wine"
    var item6 = "Shampoo & conditioner"
    var item7 = "Granola"
    var item8 = "A dozen eggs"
}
