import Foundation

extension Encodable {
    func encode() -> Data? {
        do {
            let data = try JSONEncoder().encode(self)
            return data
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
