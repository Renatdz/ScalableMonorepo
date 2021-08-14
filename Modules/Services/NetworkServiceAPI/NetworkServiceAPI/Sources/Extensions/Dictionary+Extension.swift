import Foundation

public extension Dictionary {
    func toData() -> Data? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted) else {
            return nil
        }
        return data
    }
}
