import Foundation
import Observation

// A tiny executor that isolates the use case off the main actor
actor FetchExecutor {
    private let useCase: any FetchNewsUseCase
    init(useCase: any FetchNewsUseCase) { self.useCase = useCase }

    func execute(query: String, page: Int, pageSize: Int) async -> Result<NewsFeed, Error> {
        print("fetching news for query: '\(query)' page: \(page) pageSize: \(pageSize)")
        return await useCase.execute(query: query, page: page, pageSize: pageSize)
    }
}

@Observable
public final class NewsViewModel {
    private let executor: FetchExecutor

    public init(useCase: any FetchNewsUseCase) {
        self.executor = FetchExecutor(useCase: useCase)
    }

    // MARK: - Inputs (bound from the View)
    public var searchQuery: String = ""

    // MARK: - Outputs (observed by the View)
    public private(set) var articles: [Article] = []
    public private(set) var totalResults: Int = 0
    public private(set) var errorMessage: String?

    // MARK: - Paging state (read-only to the View)
    private let pageSize: Int = 20
    public private(set) var page: Int = 1
    public private(set) var hasMore: Bool = true
    public private(set) var isRefreshing: Bool = false
    public private(set) var isPaging: Bool = false
    // MARK: - Public API

    /// Pull-to-refresh or explicit search: resets paging & loads first page
    public func fetchNews() async {
        await load(reset: true)
    }

    /// Triggered by a row near the bottom when it appears
    public func loadMoreIfNeeded(currentItem: Article) async {
        // Since the ViewModel is @MainActor, these reads are main-safe.
        guard hasMore,
              !isPaging,
              !isRefreshing,
              let idx = articles.firstIndex(where: { $0.id == currentItem.id })
        else {
            return
        }

        let threshold = max(0, articles.count - 5)
        if idx >= threshold {
            await load(reset: false)
        }
    }


    // MARK: - Core loading
    private func load(reset: Bool) async {
        if reset {
            isRefreshing = true
            page = 1
            hasMore = true
        } else {
            isPaging = true
        }
        defer {
            isRefreshing = false
            isPaging = false
        }

        let query = searchQuery
        let pageSnapshot = page
        let sizeSnapshot = pageSize

        // This hop is explicit: we're calling into another actor (not main).
        let result = await executor.execute(query: query, page: pageSnapshot, pageSize: sizeSnapshot)

        switch result {
        case .success(let feed):
            if reset {
                if feed.articles.isEmpty {
                    // Clear out old results if any
                    articles = []
                    totalResults = 0
                    hasMore = false
                    errorMessage = "No results found for \"\(query)\"."
                    return
                }
                articles = feed.articles
                totalResults = feed.totalResults
                page = pageSnapshot + 1
            } else {
                let existing = Set(articles.map(\.id))
                let newOnes = feed.articles.filter { !existing.contains($0.id) }
                articles.append(contentsOf: newOnes)
                totalResults = feed.totalResults
                page = pageSnapshot + 1
            }
            hasMore = articles.count < totalResults
            errorMessage = nil

        case .failure(let error):
            errorMessage = error.localizedDescription
        }
    }
}
