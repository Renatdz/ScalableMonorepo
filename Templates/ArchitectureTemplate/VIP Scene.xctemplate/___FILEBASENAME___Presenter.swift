import DIServiceAPI
import Foundation

protocol ___VARIABLE_moduleName___Presenting: AnyObject {
    var viewController: ___VARIABLE_moduleName___Displaying? { get set }
    func displaySomething()
}

final class ___VARIABLE_moduleName___Presenter {
    private let diService: DIServicing
    weak var viewController: ___VARIABLE_moduleName___Displaying?

    init(diService: DIServicing) {
        self.diService = diService
    }
}

// MARK: - ___VARIABLE_moduleName___Presenting
extension ___VARIABLE_moduleName___Presenter: ___VARIABLE_moduleName___Presenting {
    func displaySomething() {
        viewController?.displaySomething()
    }
}
