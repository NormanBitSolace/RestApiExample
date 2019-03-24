import XCTest
@testable import Support

class ResultTests: XCTestCase {
    override func setUp() { }
    override func tearDown() { }

    struct Model: Codable {
        let code: String
        let hello: String
    }

    func testDecode() {
        var model: Model?
        let url = URL("https://fourtonfish.com/hellosalut/?lang=us")
        let expectation = self.expectation(description: "testData")
        url.getResult { result in
            model = result.decode()
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(model)
        XCTAssertEqual("none", model?.code)
    }
}
