import Foundation

struct PetJsonModel: Codable {
    let firstName: String?
    let lastName: String?
    let practitionerId: Int?
}

struct VetJsonModel: Codable {
    let firstName: String?
    let lastName: String?
    let title: String?
}
