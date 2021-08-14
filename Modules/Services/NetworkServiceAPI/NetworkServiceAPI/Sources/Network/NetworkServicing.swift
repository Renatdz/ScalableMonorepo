import Foundation

public protocol NetworkServicing {
    @discardableResult
    func execute<T: Decodable>(
        endpoint: ApiEndpointExposable,
        completion: @escaping (Result<(model: T, data: Data?, httpStatus: HTTPStatusCode), RequestError>) -> Void
    ) -> URLSessionDataTask?
}
