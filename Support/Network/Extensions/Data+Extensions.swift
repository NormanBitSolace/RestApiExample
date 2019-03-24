import Foundation

extension Data {
    func decode<T: Codable>() -> T? {
        do {
            let decoder = JSONDecoder()
            let resource = try decoder.decode(T.self, from: self)
            return resource

        } catch {
            print(self.asString)
            print(error.localizedDescription)
        }
        return nil
    }
}

extension Data {
    var asString: String { return String(decoding: self, as: UTF8.self) }
}
