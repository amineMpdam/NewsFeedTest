import SwiftUI

struct ArticleRowView: View {
    let article: Article
    var body: some View {
        HStack {
            if let urlToImage = article.urlToImage, let url = URL(string: urlToImage) {
                AsyncImage(url: url) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 150, height: 150)
            }
            VStack(alignment: .leading, spacing: 6) {
                Text(article.title ?? "N/A")
                    .font(.headline)
                Text(article.description ?? "N/A")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                if let publishedAt = article.publishedAt, let formattedDate = publishedAt.formattedDate() {
                    Spacer()
                    HStack {
                        Spacer()
                        Text(formattedDate)
                            .font(.footnote)
                            .foregroundColor(.accentColor)
                            .lineLimit(2)
                    }
                }
            }
            .padding(.all, 6)
        }
    }
}
