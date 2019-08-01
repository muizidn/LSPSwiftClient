import XCTest
@testable import LSPSwiftClient

final class LSPSwiftClientTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(LSPSwiftClient().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
