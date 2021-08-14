import DIServiceAPI
import HomeFeatureAPI
import Foundation

protocol PasswordPresenting: AnyObject {
    var viewController: PasswordDisplaying? { get set }
    func presentHome()
}

final class PasswordPresenter {
    private let diService: DIServicing
    weak var viewController: PasswordDisplaying?

    init(diService: DIServicing) {
        self.diService = diService
    }
}

// MARK: - PasswordPresenting

extension PasswordPresenter: PasswordPresenting {
    func presentHome() {
        diService.navigate(
            to: HomeFeatureRoute(),
            from: viewController,
            presentationStyle: Push(),
            animated: true
        )
    }
}
