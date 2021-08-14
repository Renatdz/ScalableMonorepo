import Foundation

protocol UsernameInteracting: AnyObject {
    func startPassword(withCPF cpf: String)
}

final class UsernameInteractor {
    private let service: UsernameServicing
    private let presenter: UsernamePresenting

    init(service: UsernameServicing, presenter: UsernamePresenting) {
        self.service = service
        self.presenter = presenter
    }
}

// MARK: - UsernameInteracting

extension UsernameInteractor: UsernameInteracting {
    func startPassword(withCPF cpf: String) {
        presenter.present(cpf: cpf)
    }
}
