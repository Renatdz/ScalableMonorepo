import DIServiceAPI
import LoginFeatureAPI

import Foundation
import UIKit

protocol WelcomePresenting: AnyObject {
    var viewController: WelcomeDisplaying? { get set }
    
    func presentLogin()
}

final class WelcomePresenter {
    private let diService: DIServicing

    weak var viewController: WelcomeDisplaying?

    init(diService: DIServicing) {
        self.diService = diService
    }
}

// MARK: - WelcomePresenting

extension WelcomePresenter: WelcomePresenting {
    func presentLogin() {
        diService.navigate(to: UsernameRoute(),
                           from: viewController,
                           presentationStyle: BottomSheet(),
                           animated: true)
    }
}
