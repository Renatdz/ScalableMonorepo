import Foundation

protocol PasswordInteracting: AnyObject {
    func login(with password: String)
}

final class PasswordInteractor {
    private let service: PasswordServicing
    private let presenter: PasswordPresenting
    private let cpf: String
    
    init(cpf: String, service: PasswordServicing, presenter: PasswordPresenting) {
        self.cpf = cpf
        self.service = service
        self.presenter = presenter
    }
}

// MARK: - PasswordInteracting

extension PasswordInteractor: PasswordInteracting {
    func login(with password: String) {
        service.login(with: cpf, password: password) { result in
            switch result {
            case .success:
                print("Login success")
                self.presenter.presentHome()
            case let .failure(error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
