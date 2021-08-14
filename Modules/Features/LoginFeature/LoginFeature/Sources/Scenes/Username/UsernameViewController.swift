import UIHelper
import UIKit

protocol UsernameDisplaying where Self: UIViewController {
}

private extension UsernameViewController.Layout { }

final class UsernameViewController: ViewController<UsernameInteracting, UsernameView> {
    fileprivate enum Layout { }
    
    // MARK: - Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewActions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        rootView.showKeyboard()
    }
    
    // MARK: - Actions
    
    private func bindViewActions() {
        rootView.onCloseButtonTouched = { [unowned self] in
            self.dismiss(animated: true)
        }
        
        rootView.onContinueButtonTouched = { [unowned self] cpf in
            self.interactor.startPassword(withCPF: cpf)
        }
    }
}

// MARK: - UsernameDisplaying

extension UsernameViewController: UsernameDisplaying { }
