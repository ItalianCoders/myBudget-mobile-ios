//
//  myBudgetTests.swift
//  myBudgetTests
//
//  Created by Ruggiero Altini on 18/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import XCTest
@testable import myBudget

class myBudgetTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testUrlPathEncoder() {
        let path = "http://myurlsomethingblabla.com/api/v1/users/{id}/"
        
        struct __Parameters: Encodable {
            var id: Int
        }
        let parameters = __Parameters(id: 10)
       
        XCTAssertEqual(try! URLPathEncoder.encode(parameters, forUrl: path), "http://myurlsomethingblabla.com/api/v1/users/10/")
        
    }
}
