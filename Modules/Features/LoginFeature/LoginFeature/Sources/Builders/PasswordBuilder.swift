import DIServiceAPI
import NetworkServiceAPI
import LoginFeatureAPI

import UIKit

public struct PasswordBuilder: Builder {
    @Dependency var networkService: NetworkServicing
    @Dependency var diService: DIServicing
    
    public init() { }
    
    public func isEnabled() -> Bool { true }
    
    public func fallback(forRoute route: Route?) -> Builder.Type? {
        LoginFallbackBuilder.self
    }

    public func build(from route: Route?) -> UIViewController {
        guard let route = route as? PasswordRoute, route.cpf.isNotEmpty else {
            fatalError("Q PALHAÇADA É ESSA AQUI???")
        }
        return PasswordFactory.make(cpf: route.cpf, diService: diService, networkService: networkService)
    }
}
