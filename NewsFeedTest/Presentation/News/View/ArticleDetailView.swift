import SwiftUI

struct ArticleDetailView: View {
    let article: Article
    @State private var isShowingSheet = false

    private var navigationTitle: String {
        guard let articleAuthor = article.author else {
            return "Article Details"
        }
        return "Article by \(articleAuthor)"
    }

    private var articleDescription: String {
        article.description ?? "N/A"
    }

    private var articleContent: String {
        article.content ?? "N/A"
    }

    private var articleTitle: String {
        article.title ?? "No title available"
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 12) {
                if let urlToImage = article.urlToImage, let url = URL(string: urlToImage) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(maxWidth: .infinity, maxHeight: 450)
                    .padding(
                        .bottom,
                        10
                    )
                }
                Text(articleTitle)
                    .font(.title3.bold())
                    .multilineTextAlignment(.center)
                    .padding(
                        .bottom,
                        10
                    )
                Text("Description : ")
                    .font(.title3.bold())
                    .padding(
                        .bottom,
                        10
                    )
                Text(articleDescription)
                    .font(.title2)
                    .padding(
                        .bottom,
                        10
                    )
                    .padding(
                        .horizontal,
                        10
                    )
                Text("Content Summary: ")
                    .font(.title2.bold())
                    .padding(.bottom, 10)
                Text(articleContent)
                    .font(.title3)
                    .padding(
                        .horizontal,
                        10
                    )
                if let url = URL(string: article.url) {
                    Link(
                        "Open Original",
                        destination: url
                    )
                    .font(.callout)
                    .padding(
                        .top,
                        10
                    )
                }
            }
        }
        .navigationTitle(navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}
