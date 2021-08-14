import Foundation

protocol ___VARIABLE_moduleName___Interacting: AnyObject {
    func doSomething()
}

final class ___VARIABLE_moduleName___Interactor {
    private let service: ___VARIABLE_moduleName___Servicing
    private let presenter: ___VARIABLE_moduleName___Presenting

    init(service: ___VARIABLE_moduleName___Servicing, presenter: ___VARIABLE_moduleName___Presenting) {
        self.service = service
        self.presenter = presenter
    }
}

// MARK: - ___VARIABLE_moduleName___Interacting
extension ___VARIABLE_moduleName___Interactor: ___VARIABLE_moduleName___Interacting {
    func doSomething() {
        presenter.displaySomething()
    }
}
