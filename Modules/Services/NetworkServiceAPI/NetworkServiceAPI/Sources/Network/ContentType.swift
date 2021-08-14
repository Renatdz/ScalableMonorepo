import Foundation

public enum ContentType {
    case applicationJson
    
    public var rawValue: String {
        switch self {
        case .applicationJson:
            return "application/json"
        }
    }
}
