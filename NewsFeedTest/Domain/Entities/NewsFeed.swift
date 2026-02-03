public struct NewsFeed: Codable, Equatable, Sendable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}
