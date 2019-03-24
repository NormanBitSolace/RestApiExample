import XCTest
@testable import Support

class RestMethodTests: XCTestCase {

    override func setUp() { }
    override func tearDown() { }

    struct Model: Codable, Equatable {
        let code: String
        let hello: String
    }

    func testGet() {
        var model: Model?
        let method = RestMethod()
        let url = URL("https://fourtonfish.com/hellosalut/?lang=us")
        let expectation = self.expectation(description: "testData")
        method.get(type: Model.self, url: url) { serverModel in
            model = serverModel
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual("none", model?.code)
    }
}
