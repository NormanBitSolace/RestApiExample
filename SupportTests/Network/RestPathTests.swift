import XCTest
@testable import Support

class RestPathTests: XCTestCase {

    override func setUp() { }
    override func tearDown() { }

    func testSingle() {
        let path = RestPath("customers")
        XCTAssertEqual(path.component(), "/customers")
    }

    func testTwo() {
        let path = RestPath("customers", "1")
        XCTAssertEqual(path.component(), "/customers/1")
    }

    func testThree() {
        let path1 = RestPath("customers", "1")
        let path2 = RestPath("orders")
        XCTAssertEqual(path1 + path2, "/customers/1/orders")
    }

    func testFour() {
        let path1 = RestPath("customers", "1")
        let path2 = RestPath("orders", "1")
        XCTAssertEqual(path1 + path2, "/customers/1/orders/1")
    }

    func testInitWithInt() {
        let path1 = RestPath("customers", 1)
        let path2 = RestPath("orders", 1)
        XCTAssertEqual(path1 + path2, "/customers/1/orders/1")
    }

    func testURL() {
        let base = "https://www.yomama.com"
        let path1 = RestPath("customers", 1)
        let path2 = RestPath("orders", 1)
        let url = URL(base, path1, path2)
        XCTAssertEqual(url.absoluteString, "https://www.yomama.com/customers/1/orders/1")
    }

}
