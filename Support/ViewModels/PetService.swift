import Foundation

// Make it a class so we can mark it unowed or weak
protocol PetService: class {
    func pets(completion: @escaping ([PetJsonModel]?) -> Void)
    func vet(id: Int, completion: @escaping (VetJsonModel?) -> Void)
}

final class PetServiceImpl: PetService, RestHelper {

    let base = "https://wildflower-hidden-35037.v2.vapor.cloud/api"

    final func pets(completion: @escaping ([PetJsonModel]?) -> Void) {
        let url = URL("\(base)/pets")
        url.getModel(type: [PetJsonModel].self) { models in
            completion(models)
        }
    }

    final func vet(id: Int, completion: @escaping (VetJsonModel?) -> Void) {
        let url = URL("\(base)/practitioners/\(id)")
        url.getModel(type: VetJsonModel.self) { model in
            completion(model)
        }
    }
}
