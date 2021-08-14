import UIKit

public protocol RouteHandler {
    var routes: [Route.Type] { get }

    func destination(
        for route: Route,
        from viewController: UIViewController
    ) -> Builder.Type
}
