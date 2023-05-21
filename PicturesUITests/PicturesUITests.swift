//
//  PicturesUITests.swift
//  PicturesUITests
//
//  Created by Andrey on 21.05.2023.
//

import XCTest

final class PicturesUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws { }

    func testGeneratingPicture() throws {
        let app = XCUIApplication()
        app.launch()
        
        let textField = app.textFields["GeneratePicture.TextField"]
        textField.tap()
        sleep(1)
        
        let screenshotFirst = app.images.firstMatch.screenshot()
        
        textField.typeText("1234")
        
        app.buttons["GeneratePicture.Button.Submit"].tap()
        sleep(1)
        
        let screenshotSecond = app.images.firstMatch.screenshot()
        
        XCTAssertNotEqual(screenshotFirst.pngRepresentation, screenshotSecond.pngRepresentation)
        
        textField.tap()
        sleep(1)
        textField.typeText("5")
        
        app.buttons["GeneratePicture.Button.Submit"].tap()
        sleep(1)
        
        let screenshotThird = app.images.firstMatch.screenshot()
        
        XCTAssertNotEqual(screenshotSecond.pngRepresentation, screenshotThird.pngRepresentation)
    }
}
