import Foundation
import DIServiceAPI

public extension Route {
    static var asAnyRouteType: AnyRouteType {
        return AnyRouteType(self)
    }
}
