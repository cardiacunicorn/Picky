//
//  GuestEntity+CoreDataProperties.swift
//  Picky
//
//  Created by Alex Mills on 16/11/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//
//

import Foundation
import CoreData


extension GuestEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GuestEntity> {
        return NSFetchRequest<GuestEntity>(entityName: "GuestEntity")
    }

    @NSManaged public var allergies: [String]?
    @NSManaged public var diets: [String]?
    @NSManaged public var name: String?
    @NSManaged public var guestlists: NSSet?

}

// MARK: Generated accessors for guestlists
extension GuestEntity {

    @objc(addGuestlistsObject:)
    @NSManaged public func addToGuestlists(_ value: GuestlistEntity)

    @objc(removeGuestlistsObject:)
    @NSManaged public func removeFromGuestlists(_ value: GuestlistEntity)

    @objc(addGuestlists:)
    @NSManaged public func addToGuestlists(_ values: NSSet)

    @objc(removeGuestlists:)
    @NSManaged public func removeFromGuestlists(_ values: NSSet)

}
