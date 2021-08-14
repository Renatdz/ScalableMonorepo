import DIServiceAPI
import HomeFeatureAPI

import Foundation
import UIKit

public final class HomeFeatureRouteHandler: RouteHandler {
    public var routes: [Route.Type] { [HomeFeatureRoute.self] }

    public func destination(
        for route: Route,
        from viewController: UIViewController
    ) -> Builder.Type {
        guard route is HomeFeatureRoute else {
            preconditionFailure("unexpected route")
        }
        return HomeBuilder.self
    }

    public init() {}
}
