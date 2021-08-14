import DIServiceAPI

import Foundation
import UIKit

public final class DIService: DIServicing, DIServiceRegistration {
    let store: Storing
    let failureHandler: () -> Void

    private(set) var registeredRoutes = [String: (AnyRouteType, RouteHandler)]()

    public init(
        store: Storing? = nil,
        failureHandler: @escaping () -> Void = { preconditionFailure() }
    ) {
        self.store = store ?? Store()
        self.failureHandler = failureHandler
        register(dependencyFactory: { [unowned self] in
            self
        }, for: DIServicing.self)
    }

    public func register<T>(
        dependencyFactory: @escaping DependencyFactory,
        for metaType: T.Type
    ) {
        store.register(dependencyFactory, for: metaType)
    }

    public func register(routeHandler: RouteHandler) {
        routeHandler.routes.forEach {
            registeredRoutes[$0.identifier] = ($0.asAnyRouteType, routeHandler)
        }
    }

    public func navigationController(
        withInitialFeature builder: Builder.Type
    ) -> UINavigationController {
        let instance = builder.initialize(with: store)
        let rootViewController = instance.build(from: nil)
        return UINavigationController(rootViewController: rootViewController)
    }

    public func navigate(
        to route: Route,
        from viewController: UIViewController?,
        presentationStyle: PresentationStyle,
        animated: Bool,
        completion: (() -> Void)? = nil
    ) {
        guard
            let viewController = viewController, 
            let handler = handler(for: route) else {
            failureHandler()
            return
        }
        
        let destinationFeatureType = handler.destination(
            for: route,
            from: viewController
        )
        let destinationFeature = destinationFeatureType.initialize(with: store)
        let destinationViewController: UIViewController
        
        if destinationFeature.isEnabled() {
            destinationViewController = destinationFeature.build(from: route)
        } else {
            let fallbackFeatureType = destinationFeature.fallback(for: route)
            
            guard let fallbackDestinationFeature = fallbackFeatureType?.initialize(with: store) else {
                failureHandler()
                return
            }
            
            destinationViewController = fallbackDestinationFeature.build(from: route)
        }
        
        presentationStyle.present(
            viewController: destinationViewController,
            fromViewController: viewController,
            animated: animated,
            completion: completion
        )
    }

    func handler(for route: Route) -> RouteHandler? {
        let routeIdentifier = type(of: route).identifier
        return registeredRoutes[routeIdentifier]?.1
    }
}

extension DIService: DIServiceAnyRouteDecoding {
    public func decodeAnyRoute(from decoder: Decoder) throws -> (Route, String) {
        let container = try decoder.singleValueContainer()
        let identifier = try container.decode(String.self)

        guard let routeString = RouteString(fromString: identifier) else {
            throw RouteDecodingError.failedToParseRouteString
        }

        guard let routeType = registeredRoutes[routeString.scheme]?.0 else {
            throw RouteDecodingError.unregisteredRoute
        }

        do {
            let value = try routeType.decode(JSONDecoder(), routeString.parameterData)
            return (value, routeString.originalString)
        } catch {
            throw error
        }
    }

    public enum RouteDecodingError: Swift.Error {
        case unregisteredRoute
        case failedToParseRouteString
    }
}
