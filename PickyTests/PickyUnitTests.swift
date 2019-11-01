//
//  PickyTests.swift
//  PickyTests
//
//  Created by Alex Mills on 17/10/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//

import XCTest
@testable import Picky

class PickyUnitTests: XCTestCase {

    var guest:Guest = Guest(name: "Test Guest")
    var recipe:Recipe = Recipe(title: "Test Recipe", readyTime: 0, imageName: "")

    override func setUp() {
        guest = Guest(name: "Test Guest")
        recipe = Recipe(title: "Test Recipe", readyTime: 0, imageName: "")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGuest() {
        // Check nil values
        XCTAssertNotNil(guest.id)
        XCTAssertNotNil(guest.name)
        XCTAssertNotNil(guest.groups)
        XCTAssertNotNil(guest.allergies)
        XCTAssertNotNil(guest.diets)
        
        // Check invalid values
        guest.id = -1
        XCTAssertFalse(guest.id > 0)
        XCTAssertNoThrow(guest.id = -1)
        guest.id = 0
        XCTAssertFalse(guest.id > 0)
        XCTAssertNoThrow(guest.id = 0)
        
        // Assert correct values
        XCTAssertNoThrow(guest.id = 1)
        XCTAssert(guest.id > 0)
        XCTAssertNoThrow(guest.id = 999999)
        XCTAssert(guest.id > 0)
    }

    func testRecipe() {
        // Check nil values
        XCTAssertNotNil(recipe.id)
        XCTAssertNotNil(recipe.title)
        XCTAssertNotNil(recipe.readyTime)
        XCTAssertNotNil(recipe.servings)
        XCTAssertNotNil(recipe.imageName)
        XCTAssertNotNil(recipe.cuisines)
        XCTAssertNotNil(recipe.ingredients)
        XCTAssertNotNil(recipe.instructions)
        
        // Check invalid values
        recipe.id = -1
        XCTAssertFalse(recipe.id > 0)
        recipe.id = 0
        XCTAssertFalse(recipe.id > 0)
        
        recipe.readyTime = -1
        XCTAssertFalse(recipe.readyTime > 0)
        recipe.readyTime = 0
        XCTAssertFalse(recipe.readyTime > 0)
        
        recipe.servings = -1
        XCTAssertFalse(recipe.servings > 0)
        recipe.servings = 0
        XCTAssertFalse(recipe.servings > 0)
        
        // Assert correct values
        recipe.id = 1
        XCTAssertNoThrow(recipe.id = 1)
        XCTAssert(recipe.id > 0)
        
        recipe.readyTime = 1
        XCTAssertNoThrow(recipe.readyTime = 1)
        XCTAssert(recipe.readyTime > 0)
        
        recipe.servings = 1
        XCTAssertNoThrow(recipe.servings = 1)
        XCTAssert(recipe.servings > 0)
    }

}
