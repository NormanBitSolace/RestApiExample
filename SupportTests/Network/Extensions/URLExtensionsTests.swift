import XCTest
@testable import Support

class URLExtensionsTests: XCTestCase {

    override func setUp() { }
    override func tearDown() { }

    func testImage() {
        var testImage: UIImage?
        let url = URL("https://images.dog.ceo/breeds/labrador/JessieIncognito.jpg")
        let expectation = self.expectation(description: "testImage")
        url.getImage { image in
                testImage = image
                expectation.fulfill()
            }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(testImage?.size, CGSize(width: 1152, height: 740))
    }

    func testData() {
        var testData: Data?
        let url = URL("https://fourtonfish.com/hellosalut/?lang=us")
        let expectation = self.expectation(description: "testData")
        url.getData { data in
            if let data = data {
                testData = data
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual("{\"code\":\"none\",\"hello\":\"Hello\"}", testData?.asString)
    }

    func testDataResult() {
        var testData: Data?
        let url = URL("https://fourtonfish.com/hellosalut/?lang=us")
        let expectation = self.expectation(description: "testDataResult")
        url.getResult { result in
            switch result {

            case .success(let data):
                testData = data
            case .failure:
                testData = nil
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual("{\"code\":\"none\",\"hello\":\"Hello\"}", testData?.asString)
    }

    struct PetModel: Codable {
        let firstName: String
    }

    func testGetModels() {
        var petModel: PetModel?
        let url = URL("https://wildflower-hidden-35037.v2.vapor.cloud/api/pets/1")
        let expectation = self.expectation(description: "testGroupGetModels")
        url.getModel(type: PetModel.self) { model in
            petModel = model
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual("Josie", petModel?.firstName)
    }
}
