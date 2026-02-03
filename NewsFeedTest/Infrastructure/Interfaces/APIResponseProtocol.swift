public protocol APIResponseProtocol {
    func decode<T: Decodable>(_ type: T.Type) -> Result<T, Error>
}
