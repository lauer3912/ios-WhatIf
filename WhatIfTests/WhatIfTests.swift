import XCTest
@testable import WhatIf

final class WhatIfTests: XCTestCase {
    func testUIColorExtension() throws {
        let color = UIColor(hex: "#FFB347")
        XCTAssertNotNil(color)
        let invalid = UIColor(hex: "invalid")
        XCTAssertNil(invalid)
    }

    func testAppDelegateInit() throws {
        let appDelegate = AppDelegate()
        XCTAssertNotNil(appDelegate)
    }

    func testSceneDelegateInit() throws {
        let sceneDelegate = SceneDelegate()
        XCTAssertNotNil(sceneDelegate)
    }
}