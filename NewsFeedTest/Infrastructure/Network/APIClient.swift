import Foundation

public final class APIClient: APIClientProtocol {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    public func request(url: URL, method: HTTPMethod) async -> APIResponseProtocol {
        do {
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            request.timeoutInterval = 5

            let (data, _) = try await session.data(for: request)
            return APIResponse(data: data)
        } catch {
            return APIResponse(error: error)
        }
    }
}
