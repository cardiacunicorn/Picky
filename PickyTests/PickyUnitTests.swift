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
    
    var recipe:Recipe = Recipe(title: "Test Recipe", readyTime: 0, imageName: "")
    var request = Request.shared
    var cartViewModel = ShoppingCartViewModel()
    var guestViewModel = GuestsViewModel()

    override func setUp() {
        recipe = Recipe(title: "Test Recipe", readyTime: 0, imageName: "")
        request = Request.shared
        cartViewModel = ShoppingCartViewModel()
        guestViewModel = GuestsViewModel()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
    
    func testRequest() {
        // Check nil values
        XCTAssertNotNil(request.numberParam)
        XCTAssertNotNil(request.query)
        
        // Check URL parameters haven't been fed invalid values
        XCTAssert(request.numberParam > 0)
        XCTAssert(request.query == request.query.lowercased())
        
        // Check that recipes are arriving (within 5 seconds)
        sleep(5)
        XCTAssert(request.recipes.count == request.numberParam)
    }
    
    func testCartViewModel() {
        
        // Check item is added to cart, regardless of pre-existing items
        let itemCount = cartViewModel.count
        cartViewModel.addItem("Test item")
        XCTAssert(cartViewModel.count > itemCount)
        
        // Check item is deleted from cart
        cartViewModel.removeItem(byIndex: cartViewModel.count - 1)
        XCTAssert(cartViewModel.count == itemCount)
    }
    
    func testGuestViewModel() {
        
        // Check guest is added, regardless of pre-existing items
        let guestCount = guestViewModel.count
        guestViewModel.addGuest("Test item",[],[],["Default"])
        XCTAssert(cartViewModel.count > guestCount)
        
        // Check guest is removed from active guestlist
        guestViewModel.removeGuest(byIndex: guestViewModel.count - 1)
        XCTAssert(guestViewModel.count == guestCount)
        
    }
}
