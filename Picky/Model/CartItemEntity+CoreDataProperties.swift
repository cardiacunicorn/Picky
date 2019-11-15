//
//  CartItemEntity+CoreDataProperties.swift
//  Picky
//
//  Created by Alex Mills on 15/11/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//
//

import Foundation
import CoreData


extension CartItemEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CartItemEntity> {
        return NSFetchRequest<CartItemEntity>(entityName: "CartItemEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var recipe: String?

}
