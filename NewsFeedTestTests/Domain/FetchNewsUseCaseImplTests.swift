import Testing
import Foundation

@testable import NewsFeedTest

struct FetchNewsUseCaseTests {
    private let mockRepository = NewsRepositoryMock()

    @Test
    func test_execute_success() async throws {
        // GIVEN
        let expectedFeed = NewsFeed(
            status: "ok",
            totalResults: 1,
            articles: [
                Article(
                    source: Source(id: "123", name: "Example"),
                    author: "Author",
                    title: "Sample",
                    description: "Some description",
                    url: "https://example.com",
                    urlToImage: nil,
                    publishedAt: nil,
                    content: "Lorem ipsum"
                )
            ]
        )

        mockRepository.fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorReturnValue = .success(expectedFeed)

        let sut = FetchNewsUseCaseImpl(repository: mockRepository)

        // WHEN
        let result = await sut.execute(query: "Paris", page: 1, pageSize: 10)

        // THEN
        switch result {
        case .success(let feed):
            #expect(feed == expectedFeed)
        case .failure:
            Issue.record("Expected success but got failure.")
        }

        #expect(mockRepository.fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorCalled == true)
        #expect(mockRepository.fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorCallsCount == 1)
        #expect(mockRepository.fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorReceivedArguments?.query == "Paris")
        #expect(mockRepository.fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorReceivedArguments?.page == 1)
        #expect(mockRepository.fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorReceivedArguments?.pageSize == 10)
    }

    @Test
    func test_execute_failure() async throws {
        // GIVEN
        let expectedError = NSError(domain: "TestError", code: 999)
        mockRepository.fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorReturnValue = .failure(expectedError)

        let sut = FetchNewsUseCaseImpl(repository: mockRepository)

        // WHEN
        let result = await sut.execute(query: "Tokyo", page: 2, pageSize: 20)

        // THEN
        switch result {
        case .failure(let error as NSError):
            #expect(error.code == expectedError.code)
        default:
            Issue.record("Expected failure but received success.")
        }

        #expect(mockRepository.fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorCalled == true)
        #expect(mockRepository.fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorCallsCount == 1)
        #expect(mockRepository.fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorReceivedArguments?.query == "Tokyo")
        #expect(mockRepository.fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorReceivedArguments?.page == 2)
        #expect(mockRepository.fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorReceivedArguments?.pageSize == 20)
    }
}
