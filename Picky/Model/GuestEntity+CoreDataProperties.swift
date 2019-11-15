//
//  GuestEntity+CoreDataProperties.swift
//  Picky
//
//  Created by Alex Mills on 15/11/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//
//

import Foundation
import CoreData


extension GuestEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GuestEntity> {
        return NSFetchRequest<GuestEntity>(entityName: "GuestEntity")
    }

    @NSManaged public var allergies: NSObject?
    @NSManaged public var diets: NSObject?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var guestlists: GuestlistEntity?

}
