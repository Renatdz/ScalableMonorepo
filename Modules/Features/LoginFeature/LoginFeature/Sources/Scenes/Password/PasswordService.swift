import NetworkServiceAPI
import Foundation

protocol PasswordServicing {
    func login(with cpf: String, password: String, completion: @escaping (Result<Void, RequestError>) -> Void)
}

final class PasswordService {
    private let networkService: NetworkServicing

    init(networkService: NetworkServicing) {
        self.networkService = networkService
    }
}

// MARK: - PasswordServicing

extension PasswordService: PasswordServicing {
    func login(with cpf: String, password: String, completion: @escaping (Result<Void, RequestError>) -> Void) {
        completion(.success(()))
    }
}
