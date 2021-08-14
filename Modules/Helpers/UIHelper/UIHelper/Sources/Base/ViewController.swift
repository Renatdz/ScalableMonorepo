import UIKit

open class ViewController<Interactor, V: UIView>: UIViewController, ViewLayoutable {
    // MARK: - Properties
    
    public let interactor: Interactor
    
    public var rootView = V()
    
    // MARK: - Initialization
    
    public init(interactor: Interactor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    open override func loadView() {
        view = rootView
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        buildViewLayout()
    }
    
    // MARK: - ViewLayoutable

    open func buildViewHierarchy() { }
    
    open func buildViewConstraints() { }
    
    open func additionalConfig() { }
}

// MARK: - ViewController where Interactor == Void

public extension ViewController where Interactor == Void {
    convenience init(_ interactor: Interactor = ()) {
        self.init(interactor: interactor)
    }
}
