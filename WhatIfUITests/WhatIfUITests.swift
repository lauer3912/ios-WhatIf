import XCTest

final class WhatIfUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testScreenshotHome() throws {
        // Wait for app to be running
        XCTAssertTrue(app.wait(for: .runningBackground, timeout: 5) || app.wait(for: .runningForeground, timeout: 5))

        // Take screenshot of home screen
        let homeScreenshot = XCUIScreen.main.screenshot()
        let homePath = XCTAttachment(screenshot: homeScreenshot)
        homePath.name = "whatif_home"
        homePath.lifetime = .keepAlways
        add(homePath)
    }

    func testGenerateAndScreenshot() throws {
        // Find input field
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

        // Take screenshot of result
        let resultScreenshot = XCUIScreen.main.screenshot()
        let resultPath = XCTAttachment(screenshot: resultScreenshot)
        resultPath.name = "whatif_result"
        resultPath.lifetime = .keepAlways
        add(resultPath)
    }
}