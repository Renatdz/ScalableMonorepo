import NetworkServiceAPI
import DIServiceAPI

import UIKit

public struct HomeBuilder: Builder {
    @Dependency var networkService: NetworkServicing
    @Dependency var diService: DIServicing

    public init() { }
    
    public func isEnabled() -> Bool {
        return true
    }
    
    public func fallback(forRoute route: Route?) -> Builder.Type? {
        return FallbackBuilder.self
    }

    public func build(from route: Route?) -> UIViewController {
        return MainViewController(
            networkService: networkService,
            diService: diService
        )
    }
}

public struct FallbackBuilder: Builder {
    public init() {}
    
    public func build(from route: Route?) -> UIViewController {
        return FallbackViewController()
    }
}
