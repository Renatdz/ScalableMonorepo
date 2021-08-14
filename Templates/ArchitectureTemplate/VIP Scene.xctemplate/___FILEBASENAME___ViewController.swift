import UIHelper
import UIKit

protocol ___VARIABLE_moduleName___Displaying: AnyObject {
    func displaySomething()
}

private extension ___VARIABLE_moduleName___ViewController.Layout {
    //example
    enum Size {
        static let imageHeight: CGFloat = 90.0
    }
}

final class ___VARIABLE_moduleName___ViewController: ViewController<___VARIABLE_moduleName___Interacting, UIView> {
    fileprivate enum Layout { }

    override func viewDidLoad() {
        super.viewDidLoad()

        interactor.doSomething()
    }

    override func buildViewHierarchy() { }
    
    override func setupConstraints() { }

    override func configureViews() { }
}

// MARK: - ___VARIABLE_moduleName___Displaying
extension ___VARIABLE_moduleName___ViewController: ___VARIABLE_moduleName___Displaying {
    func displaySomething() { }
}
