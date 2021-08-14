import Foundation

public protocol RequestManagerProtocol {
    associatedtype Success
    associatedtype Failure where Failure: Error
    
    init(request: URLRequest, session: URLSessionProtocol, jsonDecoder: JSONDecoder, thread: DispatchQueue)
    
    func makeRequest(completion: @escaping (Result<Success, Failure>) -> Void) -> URLSessionDataTask?
}
