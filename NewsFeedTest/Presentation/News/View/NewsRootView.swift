import SwiftUI
import Observation

struct NewsRootView: View {
    @State private var viewModel: NewsViewModel
    @State private var path = NavigationPath()

    init(viewModel: NewsViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        NavigationStack(path: $path) {
            content
                .navigationTitle("News")
        }
        .searchable(text: $viewModel.searchQuery,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "Search news")
        .onSubmit(of: .search) {
            Task { await viewModel.fetchNews() } // resets paging to first page
        }
    }

    @ViewBuilder
    private var content: some View {
        Group {
            // Error view only when there's nothing to show yet
            if let error = viewModel.errorMessage, viewModel.articles.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundStyle(.yellow)
                        .font(.largeTitle)
                    Text(error).foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Initial empty state (before searching)
            } else if viewModel.articles.isEmpty, viewModel.searchQuery.isEmpty {
                ContentUnavailableView(
                    "Search News",
                    systemImage: "newspaper",
                    description: Text("Type a query to get started")
                )

            // Loading state for a search with no results yet
            } else if viewModel.articles.isEmpty {
                VStack {
                    ProgressView("Searching…")
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            // List with pagination + pull-to-refresh
            } else {
                List {
                    ForEach(viewModel.articles) { article in
                        Button {
                            path.append(article)
                        } label: {
                            ArticleRowView(article: article)
                        }
                        // Trigger pagination when this row appears near the bottom
                        .task {
                            await viewModel.loadMoreIfNeeded(currentItem: article)
                        }
                    }

                    // Bottom loading indicator during paging (non-blocking)
                    if viewModel.isPaging {
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                    }
                }
                .listStyle(.plain)
                .refreshable {
                    await viewModel.fetchNews() // pull-to-refresh resets to page 1
                }
                .navigationDestination(for: Article.self) { article in
                    ArticleDetailView(article: article)
                }
            }
        }
    }
}
