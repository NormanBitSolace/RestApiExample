import Foundation

/*
 Cominbe json model to create view model. May require serial or parallel async.
 Internationalization (i18) e.g. converting price to local format us = $4.00 uk = £4.00
 View Models have logic of when to fail based on JSON models
 */
struct ViewModelBuilder {
    static func petVetTableCellViewModels(petService: PetService, completion: @escaping ([PetVetCellViewModel]) -> Void) {
        petService.pets { models in
            guard let pets = models else { completion([]); return }
            let group = DispatchGroup()
            var viewModels = [PetVetCellViewModel]()
            for pet in pets {
                if let vetId = pet.practitionerId {
                    group.enter()
                    petService.vet(id: vetId) { vet in
                        viewModels.append(ifNotNil: PetVetCellViewModel(pet, vet))
                        group.leave()
                    }
                }
            }
            group.notify(queue: .main) { [] in
                completion(viewModels)
            }
        }
    }
}
