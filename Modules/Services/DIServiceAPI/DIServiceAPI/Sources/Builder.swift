import UIKit

public protocol Builder {
    func build(from route: Route?) -> UIViewController
    func resolve(with store: Storing)
    /// Returns whether or not a feature can be presented.
    /// Implement this method if the availability of your feature should be controlled. (feature flag, user defaults, iOS version, etc)
    /// By default, this method returns `true` (enabled). Overwrite it to manually handle the presentation logic.
    /// If your feature can be disabled, you must also implement `fallback(_:)` to provide the alternate feature to be presented.
    ///
    /// - Returns: A boolean indicating if this feature can be presented by RouterService.
    func isEnabled() -> Bool
    /// Returns the feature that should be presented instead if this feature is disabled.
    /// If a feature can be disabled, it's mandatory to provide a fallback `Feature`.
    ///
    /// - Parameters:
    ///   - route: The `Route` that triggered this feature.
    /// - Returns: The fallback feature that should be presented when this feature is disabled.
    func fallback(for route: Route?) -> Builder.Type?

    init()
}

extension Builder {
    public func resolve(with store: Storing) {
        let mirror = Mirror(reflecting: self)
        for children in mirror.children {
            if let resolvable = children.value as? Resolvable {
                resolvable.resolve(with: store)
            }
        }
    }
    public func isEnabled() -> Bool { return true }
    public func fallback(for route: Route?) -> Builder.Type? { return nil }
}
