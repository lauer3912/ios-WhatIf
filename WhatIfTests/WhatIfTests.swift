import XCTest
@testable import WhatIf

final class WhatIfTests: XCTestCase {
    func testUIColorExtension() throws {
        let color = UIColor(hex: "#FFB347")
        XCTAssertNotNil(color)
    }

    func testSampleQuestionsNotEmpty() throws {
        let homeVC = HomeViewController()
        XCTAssertFalse(homeVC.sampleQuestions.isEmpty)
    }
}