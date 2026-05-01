import XCTest

final class WhatIfUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = []
        app.launch()
    }

    func testTakeHomeScreenshot() throws {
        Thread.sleep(forTimeInterval: 3)
        let screenshot = XCUIScreen.main.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.name = "whatif_home"
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    func testTakeResultScreenshot() throws {
        // Wait for app
        Thread.sleep(forTimeInterval: 2)

        // Type a question
        let inputField = app.textFields["What if..."]
        if inputField.waitForExistence(timeout: 5) {
            inputField.tap()
            inputField.typeText("What if gravity was just a suggestion?")
        }

        // Tap generate
        let generateBtn = app.buttons["Generate →"]
        if generateBtn.waitForExistence(timeout: 5) {
            generateBtn.tap()
        }

        // Wait for result screen
        Thread.sleep(forTimeInterval: 3)

        let screenshot = XCUIScreen.main.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.name = "whatif_result"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}