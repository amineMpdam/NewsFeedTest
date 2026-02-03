import SwiftUI

//sourcery: AutoMockable
public protocol NewsRepository: Sendable {
    func fetchNews(
        query: String,
        page: Int,
        pageSize: Int
    ) async -> Result<NewsFeed, Error>
}
