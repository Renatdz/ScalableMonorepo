import DIService
import DIServiceAPI

import NetworkService
import NetworkServiceAPI

import HomeFeature
import HomeFeatureAPI

import Foundation
import UIKit

struct AppDI {
    private let diService = DIService()
    
    var rootViewController: UIViewController {
        diService.navigationController(withInitialFeature: HomeBuilder.self)
    }
    
    init() {
        registerServices()
        registerRoutes()
    }
    
    private func registerServices() {
        diService.register(dependencyFactory: {
            NetworkService()
        }, for: NetworkServicing.self)
    }
    
    private func registerRoutes() {
        diService.register(routeHandler: HomeFeatureRouteHandler())
    }
}
