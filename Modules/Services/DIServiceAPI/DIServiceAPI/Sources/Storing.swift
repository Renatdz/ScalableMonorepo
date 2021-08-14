import Foundation

public protocol Storing {
    func get<T>(_ arg: T.Type) -> T?
    func register<T>(_ arg: @escaping DependencyFactory, for metaType: T.Type)
}
