import Foundation

struct PetVetCellViewModel: Codable {
    let petName: String
    let vetNameAndTitle: String
}

extension PetVetCellViewModel {
    init?(_ petModel: PetJsonModel?, _ vetModel: VetJsonModel?) {
        guard let petModel = petModel, let vetModel = vetModel else { return nil }
        guard let petFirstName = petModel.firstName,
            let petLastName = petModel.lastName else {
                print("Server response has missing fields in PetJsonModel.")
                return nil
       }
        guard let vetFirstName = vetModel.firstName,
            let vetLastName = vetModel.lastName,
            let vetTitle = vetModel.title else {
                print("Server response has missing fields in VetJsonModel.")
                return nil
        }
        petName = "\(petFirstName) \(petLastName)"
        vetNameAndTitle =  "\(vetFirstName) \(vetLastName), \(vetTitle)"
    }
}
