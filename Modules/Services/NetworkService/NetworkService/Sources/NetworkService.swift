import DIServiceAPI
import Foundation
import NetworkServiceAPI

public final class NetworkService: NetworkServicing {
    public init() {}
    
    @discardableResult
    public func execute<T: Decodable>(
        endpoint: ApiEndpointExposable,
        completion: @escaping (Result<(model: T, data: Data?, httpStatus: HTTPStatusCode), RequestError>) -> Void
    ) -> URLSessionDataTask? {
        let request: URLRequest
        
        do {
            request = try createRequest(endpoint: endpoint)
        } catch {
            completion(.failure(.malformedRequest))
            debugPrint("Error while creating request")
            return nil
        }
        
        return RequestManager<T>(request: request).makeRequest {
            completion($0)
        }
    }
}

private extension NetworkService {
     var defaultHeaders: [String: String] {
        var headers: [String: String] = [:]
        
        let versionNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
        let buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? ""
        
        headers["app_version"] = versionNumber
        headers["device_os"] = "ios"
        headers["app_version_b"] = buildNumber
        headers["timezone"] = TimeZone.current.identifier
        
        return headers
    }
    
    func createRequest(endpoint: ApiEndpointExposable) throws -> URLRequest {
        var urlComponent = URLComponents(string: endpoint.absoluteStringUrl)
        if endpoint.method == .get && endpoint.parameters.isNotEmpty {
            urlComponent?.queryItems = endpoint.parameters
                .map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }
        
        guard let url = urlComponent?.url else {
            throw RequestError.malformedRequest
        }
        
        var request = URLRequest(url: url)
        request.addValue(endpoint.contentType.rawValue, forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = endpoint.method.rawValue
        if endpoint.shouldAppendBody, let body = endpoint.body {
            request.httpBody = body
        }
                
        let allHeaders = defaultHeaders.merging(endpoint.customHeaders) { current, _ in current }
        allHeaders.forEach { header in
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        print(request.cURLDescription())
        
        return request
    }
}
