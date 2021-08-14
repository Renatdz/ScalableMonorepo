public enum ImageDownloadError: Error, Equatable {
    case generic(Error?)
    case decodeError
    
    public static func == (lhs: ImageDownloadError, rhs: ImageDownloadError) -> Bool {
        switch (lhs, rhs) {
        case (.decodeError, .decodeError):
            return true
        case let (.generic(lhsError), .generic(rhsError)):
            return lhsError?.localizedDescription == rhsError?.localizedDescription
        default:
            return false
        }
    }
}
