//
//  SwiftXCTestTests.swift
//  SwiftXCTestTests
//
//  Created by Furkan Bingöl on 18.07.2023.
//

import XCTest
@testable import SwiftXCTest

// UNIT TESTS
final class SwiftXCTestTests: XCTestCase {

    let math = MathematicFunctions()
    
    func testAddIntegerFunction() {
        let test = math.addIntegers(x: 5, y: 8)
        
        XCTAssertEqual(test, 13)
        // XCTAssertEqual(result, 14)  --> Error! testAddIntegerFunction(): XCTAssertEqual failed: ("13") is not equal to ("14")
    }
    
    func testMultiplyIntegerFunction() {
        let test = math.multiplyIntegers(x: 9, y: 5)
        
        XCTAssertEqual(test, 45)
    }
    
    func testDivideIntegerFunction() {
        let test1 = math.divideIntegers(x: 10, y: 5)
        let test2 = math.divideIntegers(x: 7, y: 8)
        
        XCTAssertEqual(test1, 2)
        XCTAssertEqual(test2, 0)
    }
    
    
}



/*
        override func setUpWithError() throws {
            // Put setup code here. This method is called before the invocation of each test method in the class.
        }

        override func tearDownWithError() throws {
            // Put teardown code here. This method is called after the invocation of each test method in the class.
        }

        func testExample() throws {
            // This is an example of a functional test case.
            // Use XCTAssert and related functions to verify your tests produce the correct results.
            // Any test you write for XCTest can be annotated as throws and async.
            // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
            // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        }

        func testPerformanceExample() throws {
            // This is an example of a performance test case.
            self.measure {
                // Put the code you want to measure the time of here.
            }
        }
*/
