import XCTest
@testable import MoviesAPI

final class MoviesAPITests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(MoviesAPI().text, "Hello, World!")
    }
}
