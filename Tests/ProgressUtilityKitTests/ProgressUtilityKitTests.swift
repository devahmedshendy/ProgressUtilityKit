import XCTest
@testable import ProgressUtilityKit

final class ProgressUtilityKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(ProgressUtilityKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
