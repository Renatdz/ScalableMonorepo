import Foundation
import UIKit

public protocol DIServicing: DIServiceAnyRouteDecoding {
    func navigate(
        to route: Route,
        from viewController: UIViewController?,
        presentationStyle: PresentationStyle,
        animated: Bool,
        completion: (() -> Void)?
    )
}

public extension DIServicing {
    func navigate(
        to route: Route,
        from viewController: UIViewController?,
        presentationStyle: PresentationStyle,
        animated: Bool
    ) {
        navigate(
            to: route,
            from: viewController,
            presentationStyle: presentationStyle,
            animated: animated,
            completion: nil
        )
    }
}

public typealias DependencyFactory = () -> AnyObject

public protocol DIServiceRegistration {
    func register<T>(dependencyFactory: @escaping DependencyFactory, for metaType: T.Type)
    func register(routeHandler: RouteHandler)
}

public protocol DIServiceScope {
    func register(scope: String)
    func enter(scope: String)
    func leave(scope: String)
}
