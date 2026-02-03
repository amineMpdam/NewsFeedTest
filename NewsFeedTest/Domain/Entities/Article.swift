import Foundation

public struct Article: Codable, Sendable {
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

extension Article: Identifiable {
    public var id: String {
        return url
    }
}

extension Article: Hashable, Equatable {
    public static func == (lhs: Article, rhs: Article) -> Bool {
        lhs.url == rhs.url
    }
}
