import Foundation
import Testing

@testable import NewsFeedTest

struct RemoteNewsDataSourceTests {
    private let apiConfiguration = ConfigurationManagerProtocolMock()
    private let mockAPI = APIClientProtocolMock()

    @Test
    func test_fetchNews_success() async throws {
        // GIVEN
        let mockedConfig = NewsAPIConfiguration(configuration: apiConfiguration)
        let expectedFeed = NewsFeed(
            status: "okay",
            totalResults: 1,
            articles: [Article(
                source: Source(id: "someId", name: "someName"),
                author: "SomeAuthor",
                title: "someTitle",
                description: "someDescription",
                url: "https://some.url.com",
                urlToImage: nil,
                publishedAt: nil,
                content: "lorum ipsum dolorum"
            )]
        )
        let response = APIResponse(data: try JSONEncoder().encode(expectedFeed))
        apiConfiguration.underlyingApiKey = "valid-api-key"
        apiConfiguration.underlyingBaseURL = "https://api.example.com"
        mockAPI.requestUrlURLMethodHTTPMethodAnyAPIResponseProtocolReturnValue = response

        let sut = RemoteNewsDataSource(apiClient: mockAPI, apiConfiguration: mockedConfig)

        // WHEN
        let result = await sut.fetchNews(
            query: "Paris",
            page: 10,
            pageSize: 20
        )

        // THEN
        switch result {
        case .success(let feed):
            #expect(feed == expectedFeed)
        case .failure:
            Issue.record("Expected success but got failure.")
        }

        #expect(mockAPI.requestUrlURLMethodHTTPMethodAnyAPIResponseProtocolCalled == true)
        #expect(mockAPI.requestUrlURLMethodHTTPMethodAnyAPIResponseProtocolCallsCount == 1)
    }

    @Test
    func test_fetchNews_invalidURL() async throws {
        // GIVEN
        let mockedConfig = NewsAPIConfiguration(configuration: apiConfiguration)
        apiConfiguration.underlyingBaseURL = ""
        apiConfiguration.underlyingApiKey = "valid-api-key"
        
        let sut = RemoteNewsDataSource(apiClient: mockAPI, apiConfiguration: mockedConfig)

        // WHEN
        let result = await sut.fetchNews(
            query: "InvalidCity" ,
            page: 10,
            pageSize: 19
        )

        // THEN
        switch result {
        case .failure(let error):
            #expect((error as NSError).code == -1)
        case .success:
            Issue.record("Expected failure for invalid URL.")
        }

        #expect(mockAPI.requestUrlURLMethodHTTPMethodAnyAPIResponseProtocolCallsCount == 0)
    }

    @Test
    func test_fetchNews_decodingError() async throws {
        // GIVEN
        let mockedConfig = NewsAPIConfiguration(configuration: apiConfiguration)
        apiConfiguration.underlyingApiKey = "valid-api"
        apiConfiguration.underlyingBaseURL = "https://dummy-but-valid.url"

        // Provide invalid JSON
        let invalidJSON = Data("not-json".utf8)
        mockAPI.requestUrlURLMethodHTTPMethodAnyAPIResponseProtocolReturnValue =
            APIResponse(data: invalidJSON)

        let sut = RemoteNewsDataSource(apiClient: mockAPI, apiConfiguration: mockedConfig)

        // WHEN
        let result = await sut.fetchNews(
            query: "query",
            page: 15,
            pageSize: 10
        )

        // THEN
        switch result {
        case .failure:
            #expect(true) // decoding must fail
        case .success:
            Issue.record("Expected decoding failure but got success.")
        }
    }

    @Test
    func test_fetchNews_timeout() async throws {
        // GIVEN
        let mockedConfig = NewsAPIConfiguration(configuration: apiConfiguration)

        apiConfiguration.underlyingApiKey = "valid-api-key"
        apiConfiguration.underlyingBaseURL = "https://api.example.com"

        // Simulate network timeout
        mockAPI.requestUrlURLMethodHTTPMethodAnyAPIResponseProtocolReturnValue =
            APIResponse(error: URLError(.timedOut))

        let sut = RemoteNewsDataSource(apiClient: mockAPI, apiConfiguration: mockedConfig)

        // WHEN
        let result = await sut.fetchNews(
            query: "Paris",
            page: 111,
            pageSize: 15
        )

        // THEN
        switch result {
        case .failure(let error):
            let nsError = error as NSError
            #expect(nsError.domain == NSURLErrorDomain)
            #expect(nsError.code == URLError.timedOut.rawValue)
        case .success:
            Issue.record("Expected timeout failure but got success.")
        }

        // Ensure the request method was invoked once
        #expect(mockAPI.requestUrlURLMethodHTTPMethodAnyAPIResponseProtocolCallsCount == 1)
    }
}
