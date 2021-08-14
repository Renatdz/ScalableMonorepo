import DIServiceAPI
import LoginFeatureAPI

import Foundation
import UIKit

protocol UsernamePresenting: AnyObject {
    var viewController: UsernameDisplaying? { get set }
    func present(cpf: String)
}

final class UsernamePresenter {
    private let diService: DIServicing
    weak var viewController: UsernameDisplaying?

    init(diService: DIServicing) {
        self.diService = diService
    }
}

// MARK: - UsernamePresenting

extension UsernamePresenter: UsernamePresenting {
    func present(cpf: String) {
        diService.navigate(to: PasswordRoute(cpf: cpf),
                           from: viewController,
                           presentationStyle: Push(),
                           animated: true)
    }
}
