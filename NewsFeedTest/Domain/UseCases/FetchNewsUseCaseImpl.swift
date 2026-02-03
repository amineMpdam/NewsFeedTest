public final class FetchNewsUseCaseImpl: FetchNewsUseCase {
    
    private let repository: any NewsRepository

    public init(repository: any NewsRepository) {
        self.repository = repository
    }

    public func execute(
        query: String,
        page: Int,
        pageSize: Int
    ) async -> Result<NewsFeed, any Error> {
        await repository.fetchNews(
            query: query,
            page: page,
            pageSize: pageSize
        )
    }
}
