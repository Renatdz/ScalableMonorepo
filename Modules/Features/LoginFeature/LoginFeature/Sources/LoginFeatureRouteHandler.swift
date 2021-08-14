import DIServiceAPI
import LoginFeatureAPI

import Foundation
import UIKit

public final class LoginFeatureRouteHandler: RouteHandler {
    public var routes: [Route.Type] {
        [
            WelcomeRoute.self,
            UsernameRoute.self,
            PasswordRoute.self
        ]
    }

    public func destination(
        for route: Route,
        from viewController: UIViewController
    ) -> Builder.Type {
        switch route {
        case is WelcomeRoute:
            return LoginBuilder.self
        case is UsernameRoute:
            return UsernameBuilder.self
        case is PasswordRoute:
            return PasswordBuilder.self
        default:
            preconditionFailure("unexpected route")
        }
    }

    public init() {}
}
