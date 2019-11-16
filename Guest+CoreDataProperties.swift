//
//  Guest+CoreDataProperties.swift
//  Picky
//
//  Created by Alex Mills on 17/11/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//
//

import Foundation
import CoreData


extension Guest {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Guest> {
        return NSFetchRequest<Guest>(entityName: "Guest")
    }

    @NSManaged public var allergies: [String]?
    @NSManaged public var diets: [String]?
    @NSManaged public var name: String?
    @NSManaged public var guestlists: NSSet?

}

// MARK: Generated accessors for guestlists
extension Guest {

    @objc(addGuestlistsObject:)
    @NSManaged public func addToGuestlists(_ value: Guestlist)

    @objc(removeGuestlistsObject:)
    @NSManaged public func removeFromGuestlists(_ value: Guestlist)

    @objc(addGuestlists:)
    @NSManaged public func addToGuestlists(_ values: NSSet)

    @objc(removeGuestlists:)
    @NSManaged public func removeFromGuestlists(_ values: NSSet)

}
