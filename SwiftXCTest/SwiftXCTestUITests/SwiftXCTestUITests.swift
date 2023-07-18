//
//  SwiftXCTestUITests.swift
//  SwiftXCTestUITests
//
//  Created by Furkan Bingöl on 18.07.2023.
//

import XCTest

final class SwiftXCTestUITests: XCTestCase {

    func testToDoItem() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // using red button (Recording UI Test)
        let addButton = app.navigationBars["To Do List"].buttons["Add"]
        let elementsQuery = app.alerts["Add Item"].scrollViews.otherElements
        let textField = elementsQuery.collectionViews.textFields["Enter item"]
        let okButton = elementsQuery.buttons["OK"]
        
        let addedCell = app.tables.cells.containing(.staticText, identifier:"deneme").element
        
        addButton.tap()
        textField.tap()
        textField.typeText("deneme")
        okButton.tap()
        XCTAssertTrue(addedCell.exists)       // Bu yeni hücre oluştu mu, test ediyoruz.
    }
    
    
    func testDeleteItem() throws {
        let app = XCUIApplication()
        app.launch()
        
        let addButton = app.navigationBars["To Do List"].buttons["Add"]
        let elementsQuery = app.alerts["Add Item"].scrollViews.otherElements
        let textField = elementsQuery.collectionViews.textFields["Enter item"]
        let okButton = elementsQuery.buttons["OK"]
        
        let addedCell = app.tables.cells.containing(.staticText, identifier:"deneme").element
        
        addButton.tap()
        textField.tap()
        textField.typeText("deneme")
        okButton.tap()
        
        // Delete Operation
        let tablesQuery = app.tables
        let deleteButton = tablesQuery.buttons["Delete"]
        addedCell.swipeLeft()
        deleteButton.tap()
        
        XCTAssertFalse(addedCell.exists)      // Var olan hücre silindi mi, test ediyoruz.
    }

    
}


/*
     override func setUpWithError() throws {
         // Put setup code here. This method is called before the invocation of each test method in the class.

         // In UI tests it is usually best to stop immediately when a failure occurs.
         continueAfterFailure = false

         // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
     }

     override func tearDownWithError() throws {
         // Put teardown code here. This method is called after the invocation of each test method in the class.
     }

     func testExample() throws {
         // UI tests must launch the application that they test.
         let app = XCUIApplication()
         app.launch()

         // Use XCTAssert and related functions to verify your tests produce the correct results.
     }

     func testLaunchPerformance() throws {
         if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
             // This measures how long it takes to launch your application.
             measure(metrics: [XCTApplicationLaunchMetric()]) {
                 XCUIApplication().launch()
             }
         }
     }
*/
