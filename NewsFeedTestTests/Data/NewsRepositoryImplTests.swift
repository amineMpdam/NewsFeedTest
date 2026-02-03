import Testing
import Foundation

@testable import NewsFeedTest

struct NewsRepositoryImplTests {
    private let mockDataSource = NewsDataSourceMock()

    @Test
    func test_fetchNews_success() async throws {
        // GIVEN
        let expectedFeed = NewsFeed(
            status: "ok",
            totalResults: 1,
            articles: [
                Article(
                    source: Source(id: "123", name: "Example"),
                    author: "Author",
                    title: "Sample News",
                    description: "Details...",
                    url: "https://example.com",
                    urlToImage: nil,
                    publishedAt: nil,
                    content: "Lorem ipsum"
                )
            ]
        )

        mockDataSource.fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorReturnValue = .success(expectedFeed)

        let sut = NewsRepositoryImpl(dataSource: mockDataSource)

        // WHEN
        let result = await sut.fetchNews(query: "paris", page: 1, pageSize: 100)

        // THEN
        switch result {
        case .success(let feed):
            #expect(feed == expectedFeed)
        case .failure:
            Issue.record("Expected success but received failure")
        }

        #expect(mockDataSource.fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorCalled == true)
        #expect(mockDataSource.fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorCallsCount == 1)
    }

    @Test
    func test_fetchNews_failure() async throws {
        // GIVEN
        let expectedError = NSError(domain: "Test", code: 999)
        mockDataSource.fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorReturnValue = .failure(expectedError)

        let sut = NewsRepositoryImpl(dataSource: mockDataSource)

        // WHEN
        let result = await sut.fetchNews(query: "London", page: 1, pageSize: 100)

        // THEN
        switch result {
        case .failure(let error as NSError):
            #expect(error.code == expectedError.code)
        default:
            Issue.record("Expected failure but received success")
        }

        #expect(mockDataSource.fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorCalled == true)
        #expect(mockDataSource.fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorCallsCount == 1)
        #expect(mockDataSource.fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorReceivedArguments?.query == "London")
        #expect(mockDataSource.fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorReceivedArguments?.page == 1)
        #expect(mockDataSource.fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorReceivedArguments?.pageSize == 100)
    }

    @Test
    func test_fetchNews_passesCorrectQueryToDataSource() async throws {
        // GIVEN
        mockDataSource.fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorReturnValue =
            .failure(NSError(domain: "irrelevant", code: 0))

        let sut = NewsRepositoryImpl(dataSource: mockDataSource)

        // WHEN
        _ = await sut.fetchNews(query: "Tokyo", page: 2, pageSize: 50)

        // THEN
        #expect(mockDataSource.fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorCallsCount == 1)
        #expect(mockDataSource.fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorReceivedArguments?.query == "Tokyo")
        #expect(mockDataSource.fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorReceivedArguments?.page == 2)
        #expect(mockDataSource.fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorReceivedArguments?.pageSize == 50)
    }
}
