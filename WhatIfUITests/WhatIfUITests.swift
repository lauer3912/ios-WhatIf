import XCTest

final class WhatIfUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["--screenshot-on-launch"]
        app.launch()
    }

    func testScreenshotHome() throws {
        // Give time for UI to render
        Thread.sleep(forTimeInterval: 3)

        // Take screenshot
        let screenshot = XCUIScreen.main.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.name = "whatif_home"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}