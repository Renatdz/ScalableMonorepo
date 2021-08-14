import DIServiceAPI

import UIKit

enum WelcomeFactory {
    static func make(diService: DIServicing) -> WelcomeViewController {
        let presenter: WelcomePresenting = WelcomePresenter(diService: diService)
        let interactor = WelcomeInteractor(presenter: presenter)
        let viewController = WelcomeViewController(interactor: interactor)

        presenter.viewController = viewController

        return viewController
    }
}
