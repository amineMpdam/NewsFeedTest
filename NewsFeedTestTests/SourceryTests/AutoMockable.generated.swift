// Generated using Sourcery 2.3.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif


@testable import NewsFeedTest



























public final class APIClientProtocolMock: APIClientProtocol, @unchecked Sendable {
    public init() {}


    private let internalMockLock = NSLock()

    //MARK: - request

    public var requestUrlURLMethodHTTPMethodAnyAPIResponseProtocolCallsCount = 0
    public var requestUrlURLMethodHTTPMethodAnyAPIResponseProtocolCalled: Bool {
        return requestUrlURLMethodHTTPMethodAnyAPIResponseProtocolCallsCount > 0
    }
    public var requestUrlURLMethodHTTPMethodAnyAPIResponseProtocolReceivedArguments: (url: URL, method: HTTPMethod)?
    public var requestUrlURLMethodHTTPMethodAnyAPIResponseProtocolReceivedInvocations: [(url: URL, method: HTTPMethod)] = []
    public var requestUrlURLMethodHTTPMethodAnyAPIResponseProtocolReturnValue: (any APIResponseProtocol)!
    public var requestUrlURLMethodHTTPMethodAnyAPIResponseProtocolClosure: ((URL, HTTPMethod) async -> any APIResponseProtocol)?

    public func request(url: URL,method: HTTPMethod) async -> any APIResponseProtocol {
            requestUrlURLMethodHTTPMethodAnyAPIResponseProtocolCallsCount += 1
        requestUrlURLMethodHTTPMethodAnyAPIResponseProtocolReceivedArguments = (url: url, method: method)
        requestUrlURLMethodHTTPMethodAnyAPIResponseProtocolReceivedInvocations.append((url: url, method: method))
            if let requestUrlURLMethodHTTPMethodAnyAPIResponseProtocolClosure = requestUrlURLMethodHTTPMethodAnyAPIResponseProtocolClosure {
                return await requestUrlURLMethodHTTPMethodAnyAPIResponseProtocolClosure(url, method)
            } else {
                return requestUrlURLMethodHTTPMethodAnyAPIResponseProtocolReturnValue
            }
    }


}
public final class ConfigurationManagerProtocolMock: ConfigurationManagerProtocol, @unchecked Sendable {
    public init() {}

    public var baseURL: String {
        get { return underlyingBaseURL }
        set(value) { underlyingBaseURL = value }
    }
    public var underlyingBaseURL: (String)!
    public var apiKey: String {
        get { return underlyingApiKey }
        set(value) { underlyingApiKey = value }
    }
    public var underlyingApiKey: (String)!

    private let internalMockLock = NSLock()


}
public final class FetchNewsUseCaseMock: FetchNewsUseCase, @unchecked Sendable {
    public init() {}


    private let internalMockLock = NSLock()

    //MARK: - execute

    public var executeQueryStringPageIntPageSizeIntResultNewsFeedErrorCallsCount = 0
    public var executeQueryStringPageIntPageSizeIntResultNewsFeedErrorCalled: Bool {
        return executeQueryStringPageIntPageSizeIntResultNewsFeedErrorCallsCount > 0
    }
    public var executeQueryStringPageIntPageSizeIntResultNewsFeedErrorReceivedArguments: (query: String, page: Int, pageSize: Int)?
    public var executeQueryStringPageIntPageSizeIntResultNewsFeedErrorReceivedInvocations: [(query: String, page: Int, pageSize: Int)] = []
    public var executeQueryStringPageIntPageSizeIntResultNewsFeedErrorReturnValue: Result<NewsFeed, Error>!
    public var executeQueryStringPageIntPageSizeIntResultNewsFeedErrorClosure: ((String, Int, Int) async -> Result<NewsFeed, Error>)?

    public func execute(query: String,page: Int,pageSize: Int) async -> Result<NewsFeed, Error> {
            executeQueryStringPageIntPageSizeIntResultNewsFeedErrorCallsCount += 1
        executeQueryStringPageIntPageSizeIntResultNewsFeedErrorReceivedArguments = (query: query, page: page, pageSize: pageSize)
        executeQueryStringPageIntPageSizeIntResultNewsFeedErrorReceivedInvocations.append((query: query, page: page, pageSize: pageSize))
            if let executeQueryStringPageIntPageSizeIntResultNewsFeedErrorClosure = executeQueryStringPageIntPageSizeIntResultNewsFeedErrorClosure {
                return await executeQueryStringPageIntPageSizeIntResultNewsFeedErrorClosure(query, page, pageSize)
            } else {
                return executeQueryStringPageIntPageSizeIntResultNewsFeedErrorReturnValue
            }
    }


}
public final class NewsDataSourceMock: NewsDataSource, @unchecked Sendable {
    public init() {}


    private let internalMockLock = NSLock()

    //MARK: - fetchNews

    public var fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorCallsCount = 0
    public var fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorCalled: Bool {
        return fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorCallsCount > 0
    }
    public var fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorReceivedArguments: (query: String, page: Int, pageSize: Int)?
    public var fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorReceivedInvocations: [(query: String, page: Int, pageSize: Int)] = []
    public var fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorReturnValue: Result<NewsFeed, Error>!
    public var fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorClosure: ((String, Int, Int) async -> Result<NewsFeed, Error>)?

    public func fetchNews(query: String,page: Int,pageSize: Int) async -> Result<NewsFeed, Error> {
            fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorCallsCount += 1
        fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorReceivedArguments = (query: query, page: page, pageSize: pageSize)
        fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorReceivedInvocations.append((query: query, page: page, pageSize: pageSize))
            if let fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorClosure = fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorClosure {
                return await fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorClosure(query, page, pageSize)
            } else {
                return fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorReturnValue
            }
    }


}
public final class NewsRepositoryMock: NewsRepository, @unchecked Sendable {
    public init() {}


    private let internalMockLock = NSLock()

    //MARK: - fetchNews

    public var fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorCallsCount = 0
    public var fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorCalled: Bool {
        return fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorCallsCount > 0
    }
    public var fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorReceivedArguments: (query: String, page: Int, pageSize: Int)?
    public var fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorReceivedInvocations: [(query: String, page: Int, pageSize: Int)] = []
    public var fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorReturnValue: Result<NewsFeed, Error>!
    public var fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorClosure: ((String, Int, Int) async -> Result<NewsFeed, Error>)?

    public func fetchNews(query: String,page: Int,pageSize: Int) async -> Result<NewsFeed, Error> {
            fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorCallsCount += 1
        fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorReceivedArguments = (query: query, page: page, pageSize: pageSize)
        fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorReceivedInvocations.append((query: query, page: page, pageSize: pageSize))
            if let fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorClosure = fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorClosure {
                return await fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorClosure(query, page, pageSize)
            } else {
                return fetchNewsQueryStringPageIntPageSizeIntResultNewsFeedErrorReturnValue
            }
    }


}
