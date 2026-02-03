import Foundation

//sourcery: AutoMockable
public protocol NewsDataSource: Sendable {
    func fetchNews(
        query: String,
        page: Int,
        pageSize: Int
    ) async -> Result<NewsFeed, Error>
}

