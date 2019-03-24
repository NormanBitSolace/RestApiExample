import XCTest
@testable import Support

class DataExtensionTests: XCTestCase {

    override func setUp() { }
    override func tearDown() { }

    struct Model: Codable, Equatable {
        let code: String
        let hello: String
    }

    func testDecode() {
        var newModel: Model?
        let model = Model(code: "none", hello: "hi")
        if let data = try? JSONEncoder().encode(model) {
            newModel = data.decode()!
        }
        XCTAssertEqual(model, newModel)
    }
}
