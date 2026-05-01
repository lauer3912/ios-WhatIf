import XCTest
@testable import WhatIf

final class WhatIfTests: XCTestCase {
    func testUIColorExtension() throws {
        let color = UIColor(hex: "#FFB347")
        XCTAssertNotNil(color)
        let invalid = UIColor(hex: "invalid")
        XCTAssertNil(invalid)
    }

    func testReportGeneration() throws {
        let resultVC = ResultViewController(question: "What if dogs could fly?")
        XCTAssertNotNil(resultVC)
        XCTAssertEqual(resultVC.questionText, "What if dogs could fly?")
    }

    func testAppLaunch() throws {
        let appDelegate = AppDelegate()
        XCTAssertNotNil(appDelegate)
    }
}
