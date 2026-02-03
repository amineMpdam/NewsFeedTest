import Foundation
import Testing
import Observation

@testable import NewsFeedTest

struct NewsViewModelTests {
    private let mockUseCase = FetchNewsUseCaseMock()

    // MARK: - Helpers

    private func makeArticle(
        id: String = UUID().uuidString,
        title: String = "Title"
    ) -> Article {
        Article(
            source: Source(id: id, name: "Example"),
            author: "Author",
            title: title,
            description: "Description",
            url: "https://example.com/\(id)",
            urlToImage: nil,
            publishedAt: nil,
            content: "Content"
        )
    }

    // MARK: - Tests

    @Test
    @MainActor
    func test_fetchNews_success_updatesStateAndClearsError() async throws {
        // GIVEN
        let firstArticle = makeArticle(title: "Paris News")
        let expectedFeed = NewsFeed(
            status: "ok",
            totalResults: 1,
            articles: [firstArticle]
        )

        mockUseCase.executeQueryStringPageIntPageSizeIntResultNewsFeedErrorReturnValue = .success(expectedFeed)

        let vm = NewsViewModel(useCase: mockUseCase)
        vm.searchQuery = "Paris"

        // WHEN
        await vm.fetchNews()

        // THEN
        #expect(vm.articles == expectedFeed.articles)
        #expect(vm.totalResults == expectedFeed.totalResults)
        #expect(vm.errorMessage == nil)

        // Paging-related state
        #expect(vm.page == 2)
        #expect(vm.hasMore == false)

        // Verify use case invocation and arguments
        #expect(mockUseCase.executeQueryStringPageIntPageSizeIntResultNewsFeedErrorCalled == true)
        let args = mockUseCase.executeQueryStringPageIntPageSizeIntResultNewsFeedErrorReceivedArguments
        #expect(args?.query == "Paris")
        #expect(args?.page == 1)
        #expect(args?.pageSize == 20)
    }

    @Test
    @MainActor
    func test_fetchNews_failure_setsErrorAndDoesNotChangeArticles() async throws {
        // GIVEN
        let expectedError = NSError(
            domain: "TestError",
            code: 404,
            userInfo: [NSLocalizedDescriptionKey: "Not Found"]
        )

        mockUseCase.executeQueryStringPageIntPageSizeIntResultNewsFeedErrorReturnValue = .failure(expectedError)

        let vm = NewsViewModel(useCase: mockUseCase)
        vm.searchQuery = "Unknown"

        // WHEN
        await vm.fetchNews()

        // THEN
        #expect(vm.articles.isEmpty == true)
        #expect(vm.totalResults == 0)
        #expect(vm.errorMessage == "Not Found")

        #expect(vm.page == 1)

        // Verify use case invocation and arguments
        #expect(mockUseCase.executeQueryStringPageIntPageSizeIntResultNewsFeedErrorCalled == true)
        let args = mockUseCase.executeQueryStringPageIntPageSizeIntResultNewsFeedErrorReceivedArguments
        #expect(args?.query == "Unknown")
        #expect(args?.page == 1)
        #expect(args?.pageSize == 20)
    }

    @Test
    @MainActor
    func test_fetchNews_clearsPreviousErrorOnNonEmptySuccess() async throws {
        // GIVEN
        let vm = NewsViewModel(useCase: mockUseCase)

        // 1) First return an error
        let error1 = NSError(domain: "Test", code: 1, userInfo: [NSLocalizedDescriptionKey: "Oops"])
        mockUseCase.executeQueryStringPageIntPageSizeIntResultNewsFeedErrorReturnValue = .failure(error1)

        vm.searchQuery = "First"
        await vm.fetchNews()
        #expect(vm.errorMessage == "Oops")
        #expect(vm.articles.isEmpty == true)

        // 2) Then return a non-empty success (to truly clear the error)
        let article = makeArticle(title: "Second Result")
        let successFeed = NewsFeed(status: "ok", totalResults: 1, articles: [article])
        mockUseCase.executeQueryStringPageIntPageSizeIntResultNewsFeedErrorReturnValue = .success(successFeed)

        vm.searchQuery = "Second"
        await vm.fetchNews()

        #expect(vm.articles == [article])
        #expect(vm.totalResults == 1)
        #expect(vm.errorMessage == nil)
        #expect(vm.page == 2)
        #expect(vm.hasMore == false)
    }

    @Test
    @MainActor
    func test_fetchNews_multipleCalls_lastResultWins() async throws {
        // GIVEN
        let vm = NewsViewModel(useCase: mockUseCase)

        // 1) Success (non-empty so it registers as success)
        let a1 = makeArticle(title: "A1")
        let feedA = NewsFeed(status: "ok", totalResults: 1, articles: [a1])
        mockUseCase.executeQueryStringPageIntPageSizeIntResultNewsFeedErrorReturnValue = .success(feedA)

        vm.searchQuery = "A"
        await vm.fetchNews()

        #expect(vm.articles == [a1])
        #expect(vm.errorMessage == nil)

        // 2) Failure for the next query
        let error = NSError(domain: "Test", code: 500, userInfo: [NSLocalizedDescriptionKey: "Server error"])
        mockUseCase.executeQueryStringPageIntPageSizeIntResultNewsFeedErrorReturnValue = .failure(error)
        vm.searchQuery = "B"

        // WHEN
        await vm.fetchNews()

        // THEN: the last call's failure should be reflected
        #expect(vm.errorMessage == "Server error")
        // Articles should remain as they were before the failure (your VM keeps previous list on failure)
        #expect(vm.articles == [a1])

        // Verify latest invocation arguments are for query "B", page reset to 1
        let args = mockUseCase.executeQueryStringPageIntPageSizeIntResultNewsFeedErrorReceivedArguments
        #expect(args?.query == "B")
        #expect(args?.page == 1)
        #expect(args?.pageSize == 20)
    }
}
