import Foundation

public struct APIResponse: APIResponseProtocol {
    private let data: Data
    private let error: Error?

    public init(data: Data) {
        self.data = data
        self.error = nil
    }

    public init(error: Error) {
        self.data = Data()
        self.error = error
    }

    public func decode<T: Decodable>(_ type: T.Type) -> Result<T, Error> {
        if let error {
            return .failure(error)
        }

        do {
            return .success(try JSONDecoder().decode(T.self, from: data))
        } catch {
            return .failure(error)
        }
    }
}
