import NetworkServiceAPI
import DIServiceAPI

import UIKit

public struct UsernameBuilder: Builder {
    @Dependency var networkService: NetworkServicing
    @Dependency var diService: DIServicing

    public init() { }
    
    public func isEnabled() -> Bool { true }
    
    public func fallback(forRoute route: Route?) -> Builder.Type? {
        LoginFallbackBuilder.self
    }

    public func build(from route: Route?) -> UIViewController {
        let viewController = UsernameFactory.make(diService: diService, networkService: networkService)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.isNavigationBarHidden = true
        return navigationController
    }
}
