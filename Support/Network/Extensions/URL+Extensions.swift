import UIKit

extension URL {

    init(_ string: String) {
        print(string)
        guard let url = URL(string: "\(string)") else {
            preconditionFailure("App assumes '\(string)' is a valid URL.")
        }
        self = url
    }
    //  let url = URL(base, ("practitioners",1), ("pets",1))
    init(_ base: String, _ pathPair: (path: String, id: Int?)...) {
        var uri = base
        for pair in pathPair {
            uri += "/\(pair.path)"
            if let id = pair.id {
                uri += "/\(id)"
            }
        }
        self.init(uri)
    }

    func groupGetData(urls: [URL], completion: @escaping ([Data]) -> Void) {
        let group = DispatchGroup()
        var dataArray = [Data]()
        urls.forEach { url in
            group.enter()
            url.getData { data in
                dataArray.append(ifNotNil: data)
                group.leave()
            }
        }
        group.notify(queue: .main) { [] in
            completion(dataArray)
        }
    }

/* Don't make no sense!

    func groupGetImages(imageUrls: [URL], completion: @escaping ([UIImage]) -> Void) {
        let group = DispatchGroup()
        var images = [UIImage]()
        imageUrls.forEach { url in
            group.enter()
            url.getImage { image in
                images.append(ifNotNil: image)
                group.leave()
            }
        }
        group.notify(queue: .main) { [] in
            completion(images)
        }
    }

    func groupGetModels<T: Codable>(type: T.Type, urls: [URL], completion: @escaping ([T]) -> Void) {
        let group = DispatchGroup()
        var models = [T]()
        urls.forEach { url in
            group.enter()
            url.getModel(type: T.self) { model in
                models.append(ifNotNil: model)
                group.leave()
            }
        }
        group.notify(queue: .main) { [] in
            completion(models)
        }
    }
*/
    func getModel<T: Codable>(type: T.Type, completion: @escaping (T?) -> Void) {
        var req = URLRequest(url: self)
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let dataTask = URLSession.shared.dataTask(with: req) { data, _, _ in
            guard let data = data else { completion(nil); return }
            let model: T? = data.decode()
            completion(model)
        }
        dataTask.resume()
    }

    func getData(completion: @escaping (Data?) -> Void) {
        var req = URLRequest(url: self)
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let dataTask = URLSession.shared.dataTask(with: req) { data, _, _ in
            completion(data)
        }
        dataTask.resume()
    }

    func getResult(completion: @escaping (Result<Data, String>) -> Void) {
        var req = URLRequest(url: self)
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let dataTask = URLSession.shared.dataTask(with: req) { data, _, err in
            guard err == nil else { return completion(.failure(err!.localizedDescription)) }
            guard let jsonData = data else { return completion(.failure("unknown")) }
            return completion(.success(jsonData))
        }
        dataTask.resume()
    }

    func getImage(completion: @escaping (UIImage?) -> Void) {
        let req = URLRequest(url: self)
        let dataTask = URLSession.shared.dataTask(with: req) { data, _, err in
            guard let data = data, err == nil else { completion(nil); return }
            DispatchQueue.main.async {
                if let image =  UIImage(data: data) {
                    completion(image)
                } else {
                    completion(nil)
                }
            }
        }
        dataTask.resume()
    }

    func postData(data: Data, completion: @escaping (Result<Data, String>) -> Void) {
        var req = URLRequest(url: self)
        req.httpMethod = "POST"
        req.httpBody = data
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let dataTask = URLSession.shared.dataTask(with: req) { data, _, err in
            guard err == nil else { return completion(.failure(err!.localizedDescription)) }
            guard let jsonData = data else { return completion(.failure("unknown")) }
            return completion(.success(jsonData))
        }
        dataTask.resume()
    }
}
