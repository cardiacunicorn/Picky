//
//  Guestlist.swift
//  Picky
//
//  Created by Alex Mills on 1/11/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//

struct Guestlist {
    
    // public variables, rather than getters
    var id:Int = 0
    var name:String = "Default"
    var members:[Guest]
    
    init(name:String, members:[Guest]) {
        self.id += 1
        self.name = name
        self.members = members
    }
    
    // Returns the length of the guest list
    var count:Int {
        return members.endIndex + 1
    }
    
    // Returns all guest summaries to console
    var summary:String {
        var result:[String] = []
        for member in members {
            result.append(member.summary)
        }
        return result.joined(separator: "\n\n")
    }
    
    mutating func add(guest:Guest) {
        members.append(guest)
    }
    
    // TODO: Find a solution for removing a guest from a guestlist - not currently working as intended
    mutating func removeByID(guestID:Int) {
        for member in members {
            if (member.id == guestID) {
                members.remove(at: members.index(guestID, offsetBy: 0))
            }
        }
    }
    
}
