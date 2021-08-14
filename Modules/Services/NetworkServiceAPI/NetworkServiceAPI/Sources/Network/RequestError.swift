import Foundation

public enum RequestError: Error, Equatable {
    case nilData
    case badRequest
    case invalidURL
    case responseFailure
    case decodeFailure(Error?)
    case requestError(Error?)
    case malformedRequest
    case cancelled
    case connectionFailure
    case notFound
    case unauthorized
    case tooManyRequests
    case serverError
    case timeout
    case bodyNotFound
    case upgradeRequired
    case unexpected

    // TODO: - Create better descriptions
    public var localizedDescription: String {
        switch self {
        case .nilData:
            return "nilData"
        case .badRequest:
            return "badRequest"
        case .invalidURL:
            return "invalidURL"
        case .responseFailure:
            return "responseFailure"
        case .unexpected:
            return "unexpected"
        case .decodeFailure:
            return "decodeFailure"
        case .requestError:
            return "genericError"
        case .malformedRequest:
            return "malformedRequest"
        default:
            return "TEMP"
        }
    }
    
    public var rawError: Error {
        self
    }
    
    public static func == (lhs: RequestError, rhs: RequestError) -> Bool {
        switch (lhs, rhs) {
        case (.nilData, .nilData),
             (.responseFailure, .responseFailure),
             (.badRequest, .badRequest),
             (.invalidURL, .invalidURL),
             (.unexpected, .unexpected):
            return true
        case let (.decodeFailure(lhsError), .decodeFailure(rhsError)),
             let (.requestError(lhsError), .requestError(rhsError)):
            guard
                let lhsError = lhsError,
                let rhsError = rhsError
                else { return false }
            
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}
