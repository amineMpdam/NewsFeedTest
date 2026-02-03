//sourcery: AutoMockable
public protocol FetchNewsUseCase: Sendable {
    func execute(
        query: String,
        page: Int,
        pageSize: Int
    ) async -> Result<NewsFeed, Error>
}
