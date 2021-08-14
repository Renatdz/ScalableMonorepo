import SnapKit
import UIHelper
import UIKit

protocol PasswordDisplaying where Self: UIViewController  {
}

private extension PasswordViewController.Layout {
    enum Size {
        static let containerRadius: CGFloat = 8
        static let closeHeight: CGFloat = 24
        static let continueHeight: CGFloat = 56
    }
    
    enum Spacing {
        static let minimum: CGFloat = 24
        static let maximum: CGFloat = 72
    }
}

final class PasswordViewController: ViewController<PasswordInteracting, UIView> {
    fileprivate enum Layout { }

    // MARK: - Views
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = Layout.Size.containerRadius
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("X", for: .normal)
        button.setTitleColor(Colors.neutralGrey01.color, for: .normal)
        button.addTarget(self, action: #selector(didTouchCloseButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Digite sua senha"
        label.textColor = Colors.neutralGrey01.color
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continuar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.addTarget(self, action: #selector(didTouchContinueButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var paddingView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        return view
    }()
    
    private var continueButtonBottomConstraint: Constraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        passwordTextField.becomeFirstResponder()
    }
    
    override func buildViewHierarchy() {
        view.addSubview(containerView)
        containerView.addSubviews(closeButton, titleLabel, passwordTextField, continueButton, paddingView)
    }
    
    override func buildViewConstraints() {
        containerView.snp.makeConstraints {
            $0.top.equalTo(view.compatibleSafeArea.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Layout.Spacing.minimum)
            $0.trailing.equalToSuperview().inset(Layout.Spacing.minimum)
            $0.height.equalTo(Layout.Size.closeHeight)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(closeButton.snp.bottom).offset(Layout.Spacing.minimum)
            $0.leading.trailing.equalToSuperview().inset(Layout.Spacing.minimum)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Layout.Spacing.minimum)
            $0.leading.trailing.equalToSuperview().inset(Layout.Spacing.minimum)
        }
        
        continueButton.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(passwordTextField.snp.bottom).offset(Layout.Spacing.minimum)
            $0.leading.trailing.equalToSuperview()
            continueButtonBottomConstraint = $0.bottom.equalTo(view.compatibleSafeArea.bottom).constraint
            $0.height.equalTo(Layout.Size.continueHeight)
        }
        
        paddingView.snp.makeConstraints {
            $0.top.equalTo(continueButton.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func additionalConfig() {
        view.backgroundColor = .clear
        view.isOpaque = false
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
}

@objc
private extension PasswordViewController {
    func didTouchCloseButton() {
        dismiss(animated: true, completion: nil)
    }
    
    func didTouchContinueButton() {
        guard let password = passwordTextField.text, password.isNotEmpty else { return }
        interactor.login(with: password)
    }

    func keyboardWillShow(notification: NSNotification) {
        guard
            let userInfo = notification.userInfo,
            let keyboardRectValue = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let animationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
        else {
            return
        }
        
        let inset = keyboardRectValue.height - paddingView.bounds.height
        continueButtonBottomConstraint?.update(inset: inset)
        
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        guard
            let userInfo = notification.userInfo,
            let animationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
        else {
            return
        }
        
        continueButtonBottomConstraint?.update(offset: 0)
        
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - PasswordDisplaying

extension PasswordViewController: PasswordDisplaying {
}
