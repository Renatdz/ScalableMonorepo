import Foundation
import NetworkServiceAPI

struct RequestManager<T: Decodable>: RequestManagerProtocol {
    typealias SuccessResult = (model: T, data: Data?, httpStatus: HTTPStatusCode)
    typealias RequestManagerResult = Result<SuccessResult, RequestError>
    typealias CompletionResult = (RequestManagerResult) -> Void
    
    private let session: URLSessionProtocol
    private let request: URLRequest
    private let thread: DispatchQueue
    private let jsonDecoder: JSONDecoder
    
    init(
        request: URLRequest,
        session: URLSessionProtocol = URLSession.shared,
        jsonDecoder: JSONDecoder = JSONDecoder(),
        thread: DispatchQueue = DispatchQueue.main
    ) {
        self.request = request
        self.session = session
        self.thread = thread
        self.jsonDecoder = jsonDecoder
    }
    
    func makeRequest(completion: @escaping CompletionResult) -> URLSessionDataTask? {
        let task = session.dataTask(with: request) { data, response, error in
            self.thread.async {
                self.handle(
                    data: data,
                    response: response,
                    error: error,
                    completion: completion
                )
            }
        }
        
        task.resume()
        return task
    }
}

private extension RequestManager {
    func handle(
        data: Data?,
        response: URLResponse?,
        error: Error?,
        completion: CompletionResult
    ) {
        debugPrint("\(response?.debugDescription ?? "")\n\(prettyPrint(data))")
        
        if let error = error as NSError?, error.code == NSURLErrorCancelled {
            completion(.failure(.cancelled))
            return
        }
        
        if let error = error {
            completion(.failure(.requestError(error)))
            return
        }
        
        guard let response = response as? HTTPURLResponse else {
            completion(.failure(.responseFailure))
            return
        }
        
        let status = HTTPStatusCode(rawValue: response.statusCode) ?? .processing
        let result = evaluateResult(status: status, response: response, data: data)
        completion(result)
    }
    
    func evaluateResult(
        status: HTTPStatusCode,
        response: HTTPURLResponse?,
        data: Data?
    ) -> RequestManagerResult {
        let result: RequestManagerResult
        switch status {
        case .ok, .created, .accepted, .noContent:
            result = handleSuccess(data: data, response: response, status: status)
        case .badRequest, .unprocessableEntity, .preconditionFailed, .preconditionRequired:
            result = .failure(.badRequest)
        case .unauthorized:
            result = .failure(.unauthorized)
        case .notFound:
            result = .failure(.notFound)
        case .tooManyRequests:
            result = .failure(.tooManyRequests)
        case .requestTimeout:
            result = .failure(.timeout)
        case .internalServerError, .badGateway, .serviceUnavailable:
            result = .failure(.serverError)
        case .upgradeRequired:
            result = .failure(.upgradeRequired)
        default:
            result = .failure(.unexpected)
        }
        
        return result
    }
    
    func handleSuccess(data: Data?, response: HTTPURLResponse?, status: HTTPStatusCode) -> RequestManagerResult {
        switch T.self {
        case is Data.Type:
            return content(data, response: response, status: status)
        case is NoContent.Type:
            return decodeNoContentData(response: response, status: status)
        default:
            return decodeContent(from: data, response: response, status: status)
        }
    }
    
    func content(_ data: Data?, response: HTTPURLResponse?, status: HTTPStatusCode) -> RequestManagerResult {
        guard let dataCasted = data as? T else {
            return .failure(.bodyNotFound)
        }
        
        return .success(SuccessResult(model: dataCasted, data: data, httpStatus: status))
    }
    
    func decodeContent(from data: Data?, response: HTTPURLResponse?, status: HTTPStatusCode) -> RequestManagerResult {
        guard let data = data else {
            return .failure(.nilData)
        }
        
        do {
            let model = try jsonDecoder.decode(T.self, from: data)
            let success = SuccessResult(model: model, data: data, httpStatus: status)
            return .success(success)
        } catch let error {
            debugPrint("Unable to parse json \(error)")
            return .failure(.decodeFailure(error))
        }
    }
    
    func decodeNoContentData(response: HTTPURLResponse?, status: HTTPStatusCode) -> RequestManagerResult {
        guard let emptyJsonData = "{}".data(using: .utf8) else {
            return .failure(.bodyNotFound)
        }
        
        return decodeContent(from: emptyJsonData, response: response, status: status)
    }
    
    func prettyPrint(_ jsonData: Data?) -> String {
        guard let data = jsonData else {
            return ""
        }
        
        do {
            let jsonObj = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            guard JSONSerialization.isValidJSONObject(jsonObj) else {
                return String(data: data, encoding: .utf8) ?? ""
            }
            
            let data = try JSONSerialization.data(withJSONObject: jsonObj, options: .prettyPrinted)
            
            return String(data: data, encoding: .utf8) ?? ""
        } catch {
            return ""
        }
    }
}
