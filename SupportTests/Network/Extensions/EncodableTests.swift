import XCTest
@testable import Support

class EncodableTests: XCTestCase {

    override func setUp() { }
    override func tearDown() { }

    struct Model: Codable, Equatable {
        let code: String
        let hello: String
    }

    func testEncode() {
        let model = Model(code: "none", hello: "hi")
        let data = model.encode()
        let jsonData = try? JSONEncoder().encode(model)
        XCTAssertEqual(jsonData, data)
    }
}
