import NetworkServiceAPI
import DIServiceAPI

import UIKit

public struct LoginBuilder: Builder {
    @Dependency var diService: DIServicing

    public init() { }
    
    public func isEnabled() -> Bool { true }
    
    public func fallback(forRoute route: Route?) -> Builder.Type? {
        LoginFallbackBuilder.self
    }

    public func build(from route: Route?) -> UIViewController {
        WelcomeFactory.make(diService: diService)
    }
}

public struct LoginFallbackBuilder: Builder {
    @Dependency var diService: DIServicing
    
    public init() { }
    
    public func build(from route: Route?) -> UIViewController {
        WelcomeFactory.make(diService: diService)
    }
}
