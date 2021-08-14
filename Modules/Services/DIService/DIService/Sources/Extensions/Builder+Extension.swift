import UIKit
import DIServiceAPI

extension Builder {
    static func initialize(with store: Storing) -> Builder {
        let feature = Self.init()
        feature.resolve(with: store)
        return feature
    }
}
