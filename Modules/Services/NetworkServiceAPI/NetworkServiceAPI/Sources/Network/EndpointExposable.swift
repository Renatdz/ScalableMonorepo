import Foundation

public protocol ApiEndpointExposable {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any] { get }
    var body: Data? { get }
    var isTokenNeeded: Bool { get }
    var customHeaders: [String: String] { get }
    var absoluteStringUrl: String { get }
    var shouldAppendBody: Bool { get }
    var contentType: ContentType { get }
}

public extension ApiEndpointExposable {
    var baseURL: URL {
        // FIXME: URL MUST be in proper file
        guard let url = URL(string: "https://apidev.brand.com/") else {
            fatalError("You need to define the api url")
        }
        return url
    }

    var absoluteStringUrl: String {
        let basePathString = baseURL.absoluteString
        let safeBasePath = basePathString.hasSuffix("/") ? String(basePathString.dropLast()) : basePathString
        let safePath = path.starts(with: "/") || path.isEmpty ? path : "/\(path)"
        return "\(safeBasePath)\(safePath)"
    }
    
    var shouldAppendBody: Bool { method != .get && method != .delete && body != nil }

    var method: HTTPMethod { .get }
    
    var parameters: [String: Any] { [:] }
    
    var body: Data? { nil }
    
    var isTokenNeeded: Bool { true }
    
    var customHeaders: [String: String] { [:] }

    var contentType: ContentType { .applicationJson }
}
