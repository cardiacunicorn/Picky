//
//  ShoppingListItemEntity+CoreDataProperties.swift
//  Picky
//
//  Created by Alex Mills on 15/11/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//
//

import Foundation
import CoreData


extension ShoppingListItemEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShoppingListItemEntity> {
        return NSFetchRequest<ShoppingListItemEntity>(entityName: "ShoppingListItemEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var recipe: String?

}
