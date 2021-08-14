import DIServiceAPI

import NetworkServiceAPI

import UIKit

enum UsernameFactory {
    static func make(diService: DIServicing, networkService: NetworkServicing) -> UsernameViewController {
        let service: UsernameServicing = UsernameService(networkService: networkService)
        let presenter: UsernamePresenting = UsernamePresenter(diService: diService)
        let interactor = UsernameInteractor(service: service, presenter: presenter)
        let viewController = UsernameViewController(interactor: interactor)

        presenter.viewController = viewController

        return viewController
    }
}
