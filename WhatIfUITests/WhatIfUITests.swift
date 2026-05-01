import XCTest

final class WhatIfUITests: XCTestCase {
    var app: XCUIApplication!
    var shortWait: Double { 0.5 }
    var mediumWait: Double { 1.0 }

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testScreenshotHome() {
        // Wait for home screen to load
        XCTAssertTrue(app.wait(for: .runningFront, timeout: 5))

        // Take screenshot
        let homeScreenshot = XCUIScreen.main.screenshot()
        let homePath = XCTAttachment( screenshot: homeScreenshot)
        homePath.name = "whatif_home"
        homePath.lifetime = .keepAlways
        add( homePath)
    }

    func testGenerateAndScreenshot() {
        // Find input field and enter a question
        let inputField = app.textFields["What if..."]
        if inputField.waitForExistence(timeout: 3) {
            inputField.tap()
            inputField.typeText("What if gravity was just a suggestion?")
        }

        // Tap generate button
        let generateBtn = app.buttons["Generate →"]
        if generateBtn.waitForExistence(timeout: 3) {
            generateBtn.tap()
        }

        // Wait for result screen
        Thread.sleep(forTimeInterval: 2)

        // Take screenshot
        let resultScreenshot = XCUIScreen.main.screenshot()
        let resultPath = XCTAttachment(screenshot: resultScreenshot)
        resultPath.name = "whatif_result"
        resultPath.lifetime = .keepAlways
        add(resultPath)
    }
}