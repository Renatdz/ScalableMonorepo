import DIServiceAPI
import NetworkServiceAPI

import UIKit

final class MainViewController: UIViewController {
    let networkService: NetworkServicing
    let diService: DIServicing

    init(
        networkService: NetworkServicing,
        diService: DIServicing
    ) {
        self.networkService = networkService
        self.diService = diService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
    }
}
