import Lottie
import SnapKit
import UIHelper
import UIKit

private extension SplashScreenViewController.Layout {
    enum Size {
        static let animationViewHeight = 105
    }
    
    enum Spacing {
        static let `default` = 24
    }
}

final class SplashScreenViewController: UIViewController {
    fileprivate enum Layout { }
    
    // MARK: - Views
    private lazy var backgroundImageView: UIImageView = {
        let image = UIImage(asset: SMAssets.Backgrounds.backgroundSplashScreen)
        return UIImageView(image: image)
    }()
    
    private lazy var animationView: AnimationView = {
        let animationView = AnimationView()
        animationView.animation = Animation.named(animationName, bundle: .main)
        animationView.loopMode = .playOnce
        animationView.isUserInteractionEnabled = false
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.isHidden = false
        return animationView
    }()
    
    // MARK: - Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    private let animationName = "logo_left_transition"
    
    let completionHandler: () -> Void
    
    // MARK: - Initialization
    
    init(completionHandler: @escaping () -> Void) {
        self.completionHandler = completionHandler
        
        super.init(nibName: nil, bundle: nil)
        
        buildViewLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playAnimation()
    }
    
    // MARK: - Private functions
    
    private func playAnimation() {
        animationView.play { [unowned self] _ in
            self.view.layoutIfNeeded()
            self.completionHandler()
        }
    }
}

// MARK: - ViewLayoutable

extension SplashScreenViewController: ViewLayoutable {
    func buildViewHierarchy() {
        view.addSubviews(backgroundImageView, animationView)
    }
    
    func buildViewConstraints() {
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        animationView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(Layout.Spacing.default)
            $0.height.equalTo(Layout.Size.animationViewHeight)
        }
    }
}
