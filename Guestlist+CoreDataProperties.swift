//
//  Guestlist+CoreDataProperties.swift
//  Picky
//
//  Created by Alex Mills on 17/11/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//
//

import Foundation
import CoreData


extension Guestlist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Guestlist> {
        return NSFetchRequest<Guestlist>(entityName: "Guestlist")
    }

    @NSManaged public var allergies: [String]?
    @NSManaged public var diets: [String]?
    @NSManaged public var name: String?
    @NSManaged public var guests: NSSet?

}

// MARK: Generated accessors for guests
extension Guestlist {

    @objc(addGuestsObject:)
    @NSManaged public func addToGuests(_ value: Guest)

    @objc(removeGuestsObject:)
    @NSManaged public func removeFromGuests(_ value: Guest)

    @objc(addGuests:)
    @NSManaged public func addToGuests(_ values: NSSet)

    @objc(removeGuests:)
    @NSManaged public func removeFromGuests(_ values: NSSet)

}
