//
//  ModelUnitTests.swift
//  PickyTests
//
//  Created by Alex Mills on 31/10/19.
//  Copyright © 2019 Alex Mills. All rights reserved.
//

import XCTest

@testable import Picky

class ModelUnitTests: XCTestCase {

    var recipe:Recipe = Recipe(title: "Test Recipe", readyTime: 0, imageName: "acorn-squash")
    var guest:Guest = Guest(id: 0, name: "Test Guest")

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testGuest() {
        
    }

    func testRecipe() {
        
    }
    
}
