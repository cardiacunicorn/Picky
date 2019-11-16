//
//  GuestlistEntity+CoreDataProperties.swift
//  Picky
//
//  Created by Alex Mills on 16/11/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//
//

import Foundation
import CoreData


extension GuestlistEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GuestlistEntity> {
        return NSFetchRequest<GuestlistEntity>(entityName: "GuestlistEntity")
    }

    @NSManaged public var allergies: [String]?
    @NSManaged public var diets: [String]?
    @NSManaged public var name: String?
    @NSManaged public var guests: NSSet?

}

// MARK: Generated accessors for guests
extension GuestlistEntity {

    @objc(addGuestsObject:)
    @NSManaged public func addToGuests(_ value: GuestEntity)

    @objc(removeGuestsObject:)
    @NSManaged public func removeFromGuests(_ value: GuestEntity)

    @objc(addGuests:)
    @NSManaged public func addToGuests(_ values: NSSet)

    @objc(removeGuests:)
    @NSManaged public func removeFromGuests(_ values: NSSet)

}
