import NetworkServiceAPI

import Foundation

protocol UsernameServicing {
}

final class UsernameService {
    private let networkService: NetworkServicing

    init(networkService: NetworkServicing) {
        self.networkService = networkService
    }
}

// MARK: - UsernameServicing

extension UsernameService: UsernameServicing {
}
