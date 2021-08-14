import Foundation

protocol WelcomeInteracting: AnyObject {
    func startLogin()
}

final class WelcomeInteractor {
    private let presenter: WelcomePresenting

    init(presenter: WelcomePresenting) {
        self.presenter = presenter
    }
}

// MARK: - WelcomeInteracting

extension WelcomeInteractor: WelcomeInteracting {
    func startLogin() {
        presenter.presentLogin()
    }
}
