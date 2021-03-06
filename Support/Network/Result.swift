import Foundation

enum Result<Success, Failure> {
    case success(Success)
    case failure(Failure)
}

extension Result where Success == Data {
    func decode<T: Codable>() -> T? {
        if case let .success(data) = self {
            if let model: T = data.decode() {
                return model
            }
        }
        return nil
    }
}
