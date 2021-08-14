import DIServiceAPI
import NetworkServiceAPI
import UIKit

enum PasswordFactory {
    static func make(cpf: String, diService: DIServicing, networkService: NetworkServicing) -> PasswordViewController {
        let service: PasswordServicing = PasswordService(networkService: networkService)
        let presenter: PasswordPresenting = PasswordPresenter(diService: diService)
        let interactor = PasswordInteractor(cpf: cpf, service: service, presenter: presenter)
        let viewController = PasswordViewController(interactor: interactor)

        presenter.viewController = viewController

        return viewController
    }
}
