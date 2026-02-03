import Foundation

//sourcery: AutoMockable
public protocol APIClientProtocol: Sendable {
    func request(url: URL, method: HTTPMethod) async -> any APIResponseProtocol
}

