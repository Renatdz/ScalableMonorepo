import UIHelper
import UIKit

protocol WelcomeDisplaying where Self: UIViewController { }

final class WelcomeViewController: ViewController<WelcomeInteracting, WelcomeView> {
    // MARK: - Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewActions()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func bindViewActions() {
        rootView.onBeginButtonTouched = { [unowned self] in
            self.interactor.startLogin()
        }
    }
}

// MARK: - WelcomeDisplaying

extension WelcomeViewController: WelcomeDisplaying { }
