import SnapKit
import UIHelper
import UIKit

private extension WelcomeView.Layout {
    enum Size {
        static let logoHeight = 46
        static let buttonHeight = 48
    }
    
    enum Spacing {
        static let minimum = 24
        static let maximum = 72
    }
}

final class WelcomeView: UIView {
    fileprivate enum Layout { }
    
    // MARK: - Views
    
    private lazy var backgroundImageView: UIImageView = {
        let image = UIImage(asset: LoginAssets.Backgrounds.backgroundWelcome)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private lazy var logoImageView: UIImageView = {
        let image = UIImage(asset: Assets.Imagotipos.imagotipoPortoHorizontal)
        return UIImageView(image: image)
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = LoginStrings.Welcome.title
        label.textColor = Colors.neutralGrey04.color
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private lazy var beginButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 4
        button.setTitle(LoginStrings.Welcome.begin, for: .normal)
        button.setTitleColor(Colors.brandColorSecondary.color, for: .normal)
        button.setTitleColor(Colors.brandColorDarker.color, for: .highlighted)
        button.backgroundColor = Colors.neutralGrey04.color
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.addTarget(self, action: #selector(didTouchBeginButton), for: .touchUpInside)
        return button
        
    }()
    
    private lazy var versionLabel: UILabel = {
        let label = UILabel()
        label.text = LoginStrings.Welcome.version("1.28.0")
        label.textColor = Colors.neutralGrey04.color
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    // MARK: - Properties
    
    var onBeginButtonTouched: (() -> Void)?
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildViewLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Handlers

@objc
private extension WelcomeView {
    func didTouchBeginButton() {
        onBeginButtonTouched?()
    }
}

// MARK: - ViewLayoutable

extension WelcomeView: ViewLayoutable {
    func buildViewHierarchy() {
        addSubviews(
            backgroundImageView,
            logoImageView,
            titleLabel,
            beginButton,
            versionLabel
        )
    }
    
    func buildViewConstraints() {
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(compatibleSafeArea.top).offset(Layout.Spacing.minimum)
            $0.leading.equalToSuperview().offset(Layout.Spacing.minimum)
            $0.height.equalTo(Layout.Size.logoHeight)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Layout.Spacing.minimum)
        }
        
        beginButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Layout.Spacing.minimum)
            $0.leading.trailing.equalToSuperview().inset(Layout.Spacing.minimum)
            $0.height.equalTo(Layout.Size.buttonHeight)
        }
        
        versionLabel.snp.makeConstraints {
            $0.top.equalTo(beginButton.snp.bottom).offset(Layout.Spacing.maximum)
            $0.leading.trailing.equalToSuperview().inset(Layout.Spacing.minimum)
            $0.bottom.equalTo(compatibleSafeArea.bottom).inset(Layout.Spacing.minimum)
        }
    }
}
