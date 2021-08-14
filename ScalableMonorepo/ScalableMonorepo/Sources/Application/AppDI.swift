import DIService
import DIServiceAPI

import HomeFeature
import LoginFeature

import NetworkService
import NetworkServiceAPI

import UIKit

struct AppDI {
    private let diService = DIService()
    
    var rootViewController: UIViewController {
        diService.navigationController(withInitialFeature: LoginBuilder.self)
    }
    
    init() {
        registerServices()
        registerFeatures()
    }
    
    private func registerServices() {
        diService.register(dependencyFactory: {
            NetworkService()
        }, for: NetworkServicing.self)
    }
    
    private func registerFeatures() {
        diService.register(routeHandler: LoginFeatureRouteHandler())
        diService.register(routeHandler: HomeFeatureRouteHandler())
    }
}
