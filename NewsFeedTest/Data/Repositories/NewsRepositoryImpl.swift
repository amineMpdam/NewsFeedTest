import Foundation

public final class NewsRepositoryImpl: NewsRepository {    
    private let dataSource: any NewsDataSource

    public init(dataSource: any NewsDataSource) {
        self.dataSource = dataSource
    }
    
    public func fetchNews(
        query: String,
        page: Int,
        pageSize: Int
    ) async -> Result<NewsFeed, any Error> {
        await dataSource.fetchNews(
            query: query,
            page: page,
            pageSize: pageSize
        )
    }
}

