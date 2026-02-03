import Foundation

public final class RemoteNewsDataSource: NewsDataSource {
    private let apiClient: any APIClientProtocol
    private let apiConfiguration: NewsAPIConfiguration
    
    public init(apiClient: any APIClientProtocol, apiConfiguration: NewsAPIConfiguration) {
        self.apiClient = apiClient
        self.apiConfiguration = apiConfiguration
    }

    public func fetchNews(
        query: String,
        page: Int,
        pageSize: Int
    ) async -> Result<NewsFeed, Error> {
        guard let url = apiConfiguration.makeNewsURL(
            query: query,
            page: page,
            pageSize: pageSize
        ) else {
            return .failure(
                NSError(
                    domain: "",
                    code: -1,
                    userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]
                )
            )
        }
        return await apiClient
            .request(url: url, method: .get)
            .decode(NewsFeed.self)
    }
}


