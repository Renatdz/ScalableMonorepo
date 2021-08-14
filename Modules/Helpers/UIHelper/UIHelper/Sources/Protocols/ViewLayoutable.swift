public protocol ViewLayoutable: AnyObject {
    func buildViewHierarchy()
    func buildViewConstraints()
    func additionalConfig()
    func buildViewLayout()
}

public extension ViewLayoutable {
    func buildViewLayout() {
        buildViewHierarchy()
        buildViewConstraints()
        additionalConfig()
    }
    
    func additionalConfig() { }
}
