import Foundation

public final class NewsAPIConfiguration: Sendable {
    private let configuration: ConfigurationManagerProtocol
    
    init(configuration: ConfigurationManagerProtocol) {
        self.configuration = configuration
    }
    
    func makeNewsURL(
        query: String,
        page: Int,
        pageSize: Int
    ) -> URL? {
        let baseURL = configuration.baseURL
        let apiKey = configuration.apiKey
        
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "apiKey", value: apiKey),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "apiKey", value: String(pageSize)),
        ]
        // Ensure valid absolute URL
        guard let url = components?.url,
              url.scheme == "https" || url.scheme == "http",
              url.host != nil else
        {
            return nil
        }

        return components?.url
    }
}
