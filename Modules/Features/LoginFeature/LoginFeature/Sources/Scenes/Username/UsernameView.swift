import SnapKit
import UIHelper
import UIKit

private extension UsernameView.Layout {
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

final class UsernameView: UIView {
    fileprivate enum Layout { }
    
    // MARK: - Views
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.neutralColorWhite.color
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
        label.text = "Digite seu CPF (apenas números)"
        label.textColor = Colors.neutralDarkest.color
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private lazy var cpfTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continuar", for: .normal)
        button.setTitleColor(Colors.neutralColorWhite.color, for: .normal)
        button.backgroundColor = Colors.brandColorPrimary.color
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.addTarget(self, action: #selector(didTouchContinueButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var paddingView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.brandColorPrimary.color
        return view
    }()
    
    // MARK: - Properties
    
    private var continueButtonBottomConstraint: Constraint?
    
    var onCloseButtonTouched: (() -> Void)?
    var onContinueButtonTouched: ((String) -> Void)?
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildViewLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showKeyboard() {
        cpfTextField.becomeFirstResponder()
    }
}

// MARK: - Handlers

@objc
private extension UsernameView {
    func didTouchCloseButton() {
        onCloseButtonTouched?()
    }
    
    func didTouchContinueButton() {
        guard let text = cpfTextField.text, text.isNotEmpty else { return }
        onContinueButtonTouched?(text)
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
            self.layoutIfNeeded()
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
            self.layoutIfNeeded()
        }
    }
}

// MARK: - ViewLayoutable

extension UsernameView: ViewLayoutable {
    func buildViewHierarchy() {
        addSubview(containerView)
        containerView.addSubviews(closeButton, titleLabel, cpfTextField, continueButton, paddingView)
    }
    
    func buildViewConstraints() {
        containerView.snp.makeConstraints {
            $0.top.equalTo(compatibleSafeArea.top)
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
        
        cpfTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Layout.Spacing.minimum)
            $0.leading.trailing.equalToSuperview().inset(Layout.Spacing.minimum)
        }
        
        continueButton.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(cpfTextField.snp.bottom).offset(Layout.Spacing.minimum)
            $0.leading.trailing.equalToSuperview()
            continueButtonBottomConstraint = $0.bottom.equalTo(compatibleSafeArea.bottom).constraint
            $0.height.equalTo(Layout.Size.continueHeight)
        }
        
        paddingView.snp.makeConstraints {
            $0.top.equalTo(continueButton.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func additionalConfig() {
        backgroundColor = .clear
        isOpaque = false
        
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
