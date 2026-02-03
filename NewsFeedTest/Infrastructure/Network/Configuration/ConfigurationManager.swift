import Foundation

final class ConfigurationManager: ConfigurationManagerProtocol {

    var baseURL: String {
        return "https://newsapi.org/v2/everything"
    }
    
    var apiKey: String {
        return "2ac88b9af46546bfa440c32f596e8875"
    }
}

