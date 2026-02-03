import Foundation

//sourcery: AutoMockable
public protocol ConfigurationManagerProtocol: Sendable {
    var baseURL: String { get }
    var apiKey: String { get }
}

